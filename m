Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478B1459EA3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Nov 2021 09:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhKWI4w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Nov 2021 03:56:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36848 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbhKWI4t (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Nov 2021 03:56:49 -0500
Date:   Tue, 23 Nov 2021 08:53:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637657620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Au49ldUitnUM+f2jQ7ljTDqy2dFxPGvzpG0IcL1lAVg=;
        b=qi8bAzF0tnIofjI3rNyLexfdfi+lfSdmSHhnGaHjqjQsfaLYFhJbKE6a9YKGq1Q2KnLMc6
        liyn58qFUWVlc+VmrqTCj0i6YkDgj9ticuLC6p3131wxFLN1asTKuBB00242eVH+/hSj0t
        lUG3bUiC2rOc//mLgDhagHpZbu5+RAAVZKonFAe7NsOkl2LFuYjEKH33pGWO5+wG4qPHNg
        qW1KWpXI3C/wvD1BAwdzCw+ZUBTKxWK+wrGod8Waq8BurhyR2mS9FFs3zPYd0cqwheMrIf
        LVI1b2A8vP/orUbyFBI0xxiFq8QTEPW1bz8CLfYCfxHBljKRK2SD0q0IgrwaMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637657620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Au49ldUitnUM+f2jQ7ljTDqy2dFxPGvzpG0IcL1lAVg=;
        b=PCgK3PkKyx9ESMDK3BjAJdKyBQUtpMezZ7yIA/9PmFPacS0TjE3aDRc3gK4O1vTH/KO6Xv
        cUsYN8wqnIv12lCw==
From:   "tip-bot2 for Muchun Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/rwsem: Optimize down_read_trylock()
 under highly contended case
Cc:     Muchun Song <songmuchun@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211118094455.9068-1-songmuchun@bytedance.com>
References: <20211118094455.9068-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Message-ID: <163765761910.11128.6653114470418982159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     14c24048841151548a3f4d9e218510c844c1b737
Gitweb:        https://git.kernel.org/tip/14c24048841151548a3f4d9e218510c844c=
1b737
Author:        Muchun Song <songmuchun@bytedance.com>
AuthorDate:    Thu, 18 Nov 2021 17:44:55 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Nov 2021 09:45:36 +01:00

locking/rwsem: Optimize down_read_trylock() under highly contended case

We found that a process with 10 thousnads threads has been encountered
a regression problem from Linux-v4.14 to Linux-v5.4. It is a kind of
workload which will concurrently allocate lots of memory in different
threads sometimes. In this case, we will see the down_read_trylock()
with a high hotspot. Therefore, we suppose that rwsem has a regression
at least since Linux-v5.4. In order to easily debug this problem, we
write a simply benchmark to create the similar situation lile the
following.

  ```c++
  #include <sys/mman.h>
  #include <sys/time.h>
  #include <sys/resource.h>
  #include <sched.h>

  #include <cstdio>
  #include <cassert>
  #include <thread>
  #include <vector>
  #include <chrono>

  volatile int mutex;

  void trigger(int cpu, char* ptr, std::size_t sz)
  {
  	cpu_set_t set;
  	CPU_ZERO(&set);
  	CPU_SET(cpu, &set);
  	assert(pthread_setaffinity_np(pthread_self(), sizeof(set), &set) =3D=3D 0);

  	while (mutex);

  	for (std::size_t i =3D 0; i < sz; i +=3D 4096) {
  		*ptr =3D '\0';
  		ptr +=3D 4096;
  	}
  }

  int main(int argc, char* argv[])
  {
  	std::size_t sz =3D 100;

  	if (argc > 1)
  		sz =3D atoi(argv[1]);

  	auto nproc =3D std::thread::hardware_concurrency();
  	std::vector<std::thread> thr;
  	sz <<=3D 30;
  	auto* ptr =3D mmap(nullptr, sz, PROT_READ | PROT_WRITE, MAP_ANON |
			 MAP_PRIVATE, -1, 0);
  	assert(ptr !=3D MAP_FAILED);
  	char* cptr =3D static_cast<char*>(ptr);
  	auto run =3D sz / nproc;
  	run =3D (run >> 12) << 12;

  	mutex =3D 1;

  	for (auto i =3D 0U; i < nproc; ++i) {
  		thr.emplace_back(std::thread([i, cptr, run]() { trigger(i, cptr, run); })=
);
  		cptr +=3D run;
  	}

  	rusage usage_start;
  	getrusage(RUSAGE_SELF, &usage_start);
  	auto start =3D std::chrono::system_clock::now();

  	mutex =3D 0;

  	for (auto& t : thr)
  		t.join();

  	rusage usage_end;
  	getrusage(RUSAGE_SELF, &usage_end);
  	auto end =3D std::chrono::system_clock::now();
  	timeval utime;
  	timeval stime;
  	timersub(&usage_end.ru_utime, &usage_start.ru_utime, &utime);
  	timersub(&usage_end.ru_stime, &usage_start.ru_stime, &stime);
  	printf("usr: %ld.%06ld\n", utime.tv_sec, utime.tv_usec);
  	printf("sys: %ld.%06ld\n", stime.tv_sec, stime.tv_usec);
  	printf("real: %lu\n",
  	       std::chrono::duration_cast<std::chrono::milliseconds>(end -
  	       start).count());

  	return 0;
  }
  ```

The functionality of above program is simply which creates `nproc`
threads and each of them are trying to touch memory (trigger page
fault) on different CPU. Then we will see the similar profile by
`perf top`.

  25.55%  [kernel]                  [k] down_read_trylock
  14.78%  [kernel]                  [k] handle_mm_fault
  13.45%  [kernel]                  [k] up_read
   8.61%  [kernel]                  [k] clear_page_erms
   3.89%  [kernel]                  [k] __do_page_fault

The highest hot instruction, which accounts for about 92%, in
down_read_trylock() is cmpxchg like the following.

  91.89 =E2=94=82      lock   cmpxchg %rdx,(%rdi)

Sice the problem is found by migrating from Linux-v4.14 to Linux-v5.4,
so we easily found that the commit ddb20d1d3aed ("locking/rwsem: Optimize
down_read_trylock()") caused the regression. The reason is that the
commit assumes the rwsem is not contended at all. But it is not always
true for mmap lock which could be contended with thousands threads.
So most threads almost need to run at least 2 times of "cmpxchg" to
acquire the lock. The overhead of atomic operation is higher than
non-atomic instructions, which caused the regression.

By using the above benchmark, the real executing time on a x86-64 system
before and after the patch were:

                  Before Patch  After Patch
   # of Threads      real          real     reduced by
   ------------     ------        ------    ----------
         1          65,373        65,206       ~0.0%
         4          15,467        15,378       ~0.5%
        40           6,214         5,528      ~11.0%

For the uncontended case, the new down_read_trylock() is the same as
before. For the contended cases, the new down_read_trylock() is faster
than before. The more contended, the more fast.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20211118094455.9068-1-songmuchun@bytedance.com
---
 kernel/locking/rwsem.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index e039cf1..04a74d0 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1248,17 +1248,14 @@ static inline int __down_read_trylock(struct rw_semap=
hore *sem)
=20
 	DEBUG_RWSEMS_WARN_ON(sem->magic !=3D sem, sem);
=20
-	/*
-	 * Optimize for the case when the rwsem is not locked at all.
-	 */
-	tmp =3D RWSEM_UNLOCKED_VALUE;
-	do {
+	tmp =3D atomic_long_read(&sem->count);
+	while (!(tmp & RWSEM_READ_FAILED_MASK)) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-					tmp + RWSEM_READER_BIAS)) {
+						    tmp + RWSEM_READER_BIAS)) {
 			rwsem_set_reader_owned(sem);
 			return 1;
 		}
-	} while (!(tmp & RWSEM_READ_FAILED_MASK));
+	}
 	return 0;
 }
=20
