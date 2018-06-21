#include <iostream>
#include <stdio.h>
#include <math.h>
#define N 1			// N-way
#define FILENAME "RADIX.txt"		// file to be opened
using namespace std;

const int K = 1024;

struct Data
{
	bool v;	
	unsigned int tag;
	unsigned int time;
};

struct cache_content
{
	Data data[N]; 
};

double log2(double n)
{  
    // log(n) / log(2) is log2.
    return log(n) / log(double(2));
}

void simulate(int cache_size, int block_size)
{
	//
	double miss=0,hit=0,time=0;
	bool ismiss;
	//
	unsigned int tag, index, x;

	int offset_bit = (int) log2(block_size);
	int index_bit = (int) log2(cache_size / (block_size * N));
	int line = (cache_size >> (offset_bit)) / N;

	cache_content *cache = new cache_content[line];
	
    //cout << "cache line: " << line << endl;

	for(int j = 0; j < line; j++)
		for(int k = 0; k < N; k++)
		{
			cache[j].data[k].v = false;
			cache[j].data[k].tag = 0;
			cache[j].data[k].time = 0;
		}
	
    FILE *fp = fopen(FILENAME, "r");  // read file
	
	while(fscanf(fp, "%x", &x) != EOF)
    {
    	time++;
    	ismiss = true;
		//cout << hex << x << " ";
		index = (x >> offset_bit) & (line - 1);
		tag = x >> (index_bit + offset_bit);
		
		for(int i = 0; i < N; i++)
			if(cache[index].data[i].v == true)
				if(cache[index].data[i].tag == tag)
				{
					hit++;
					ismiss = false;
					cache[index].data[i].time=time;
					break;
				}
		
		if(ismiss == true)
		{
			double t=time;
			int l=0;
			
			for(int i = 0; i < N; i++)
				if(cache[index].data[i].time < t)
				{
					t=cache[index].data[i].time;
					l=i;
				}
				
			cache[index].data[l].v=true;
			cache[index].data[l].tag=tag;
			cache[index].data[l].time=time;
			miss++;
		}
	}
	fclose(fp);
	
	cout << miss/(miss+hit)*100 << " %" << endl;

	delete [] cache;
}
	
int main()
{
	cout << " " << N << " - way :" << endl << endl;
	cout << " 1 K : ";
	simulate( 1 * K, 64);
	cout << endl << " 2 K : "; 
	simulate( 2 * K, 64);
	cout << endl << " 4 K : "; 
	simulate( 4 * K, 64);
	cout << endl << " 8 K : "; 
	simulate( 8 * K, 64);
	cout << endl << "16 K : "; 
	simulate(16 * K, 64);
	cout << endl << "32 K : "; 
	simulate(32 * K, 64);
}
