Return-Path: <linux-tip-commits+bounces-7346-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 672FBC5D6DD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 14:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B0FC4F2566
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EED304BBC;
	Fri, 14 Nov 2025 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="soV2D3Qi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="39WSwaqz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD019AD5C;
	Fri, 14 Nov 2025 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763127894; cv=none; b=KrmF5lCDQxHK6pcXpBS++bReArmsB996PmwCTbS23I2KEzKrJr/Cpmb101KmCTHBSjb3RaE4yHt4uFRSROvOpcTsIxbbnqPvRXeBQjqdvbgelnYm/bJZYFnLkoAKDVDPglWYF7cmjvhIVzcm9pUPxErdQiHJxRGAx1l7H4KaPcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763127894; c=relaxed/simple;
	bh=HtUSs140If1fUpR5EB5tBwOBkPzvPKYJzwLd45j2kH4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QC8zNiD9ZwkoG/vA3eb43oMlPD/yBXCcBgmcEpfww78o+74LpneAlKiJwwViFVIHIEyUAytjfemEOkDNENkxpdZOlbp3JGqtg2W2tzUEIrX6+W0xT37s0QKxdyWgGwJtUlnXFOm1RQ/TBmK0gTFh6DdGirRNxtyj0ORk/+NNgvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=soV2D3Qi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=39WSwaqz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 13:44:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763127891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zaq4iOiBIhlq4kH1oWtKKu+mkqUQ8c0C/IJZRtzIyKU=;
	b=soV2D3Qi+5b9k4JsR4+Tw1bsOXuE8CiWs+3SkxkZ/FXMSk7aR05ZxY1C0k0XfibW9GPJqT
	WjeeCSlvSCpKTVfJA+m4YOMt1V9DHeGIH8fIbNG0pblZtKOh+DtlGPEPjPckdxywYUi+o/
	fBOqe6wWkfVS2GTUwTM1nl+KFNv5Yu0+I3W/hgJOfTwPo07Px5pMq/IroxEmrAXk2h7naR
	kBOVh4iFBKvywRnUB9wcRNpINKnxIv/zPGsZvOgXlIgVmOVoKDZfXzFbW7EMmVe/dDtEPT
	vS56id3zvzQtVuFTqTVQEKpbKfVHVAJQefBXY1vqw3V5VsjeuNObS2mM/yLhbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763127891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zaq4iOiBIhlq4kH1oWtKKu+mkqUQ8c0C/IJZRtzIyKU=;
	b=39WSwaqzalP+bdkwulgeeQbmeOh63BC4dBdB1zd4Y4fu//JevZ948Sto2+DdwJw4DuQ6+n
	1mdjxqlGTXyjeIAg==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Create test for robust list
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251110224130.3044761-1-andrealmeid@igalia.com>
References: <20251110224130.3044761-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176312788967.498.13161316856848697620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     cd91b502f1b4bb81e82fbae38678c698ee5ac026
Gitweb:        https://git.kernel.org/tip/cd91b502f1b4bb81e82fbae38678c698ee5=
ac026
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Mon, 10 Nov 2025 19:41:30 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 Nov 2025 14:39:37 +01:00

selftests/futex: Create test for robust list

Create a test for the robust list mechanism. Test the following uAPI
operations:

- Creating a robust mutex where the lock waiter is wake by the kernel
  when the lock owner died
- Setting a robust list to the current task
- Getting a robust list from the current task
- Getting a robust list from another task
- Using the list_op_pending field from robust_list_head struct to test
  robustness when the lock owner dies before completing the locking
- Setting a invalid size for syscall argument `len`
- Adding multiple elements to a robust list wait waiting for each of
  them
- Creating a circular list and checking that the kernel does not get
  stuck in an infinity loop

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251110224130.3044761-1-andrealmeid@igalia.com
---
 tools/testing/selftests/futex/functional/.gitignore    |   1 +-
 tools/testing/selftests/futex/functional/Makefile      |   3 +-
 tools/testing/selftests/futex/functional/robust_list.c | 552 ++++++++-
 3 files changed, 555 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/robust_list.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/test=
ing/selftests/futex/functional/.gitignore
index 776ad65..23b9fea 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -12,3 +12,4 @@ futex_wait_uninitialized_heap
 futex_wait_wouldblock
 futex_waitv
 futex_numa
+robust_list
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testin=
g/selftests/futex/functional/Makefile
index 490ace1..af7ec30 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -22,7 +22,8 @@ TEST_GEN_PROGS :=3D \
 	futex_priv_hash \
 	futex_numa_mpol \
 	futex_waitv \
-	futex_numa
+	futex_numa \
+	robust_list
=20
 TEST_PROGS :=3D run.sh
=20
diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/tools/t=
esting/selftests/futex/functional/robust_list.c
new file mode 100644
index 0000000..e7d1254
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/robust_list.c
@@ -0,0 +1,552 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Igalia S.L.
+ *
+ * Robust list test by Andr=C3=A9 Almeida <andrealmeid@igalia.com>
+ *
+ * The robust list uAPI allows userspace to create "robust" locks, in the se=
nse
+ * that if the lock holder thread dies, the remaining threads that are waiti=
ng
+ * for the lock won't block forever, waiting for a lock that will never be
+ * released.
+ *
+ * This is achieve by userspace setting a list where a thread can enter all =
the
+ * locks (futexes) that it is holding. The robust list is a linked list, and
+ * userspace register the start of the list with the syscall set_robust_list=
().
+ * If such thread eventually dies, the kernel will walk this list, waking up=
 one
+ * thread waiting for each futex and marking the futex word with the flag
+ * FUTEX_OWNER_DIED.
+ *
+ * See also
+ *	man set_robust_list
+ *	Documententation/locking/robust-futex-ABI.rst
+ *	Documententation/locking/robust-futexes.rst
+ */
+
+#define _GNU_SOURCE
+
+#include "futextest.h"
+#include "../../kselftest_harness.h"
+
+#include <errno.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdatomic.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+#define STACK_SIZE (1024 * 1024)
+
+#define FUTEX_TIMEOUT 3
+
+#define SLEEP_US 100
+
+static pthread_barrier_t barrier, barrier2;
+
+static int set_robust_list(struct robust_list_head *head, size_t len)
+{
+	return syscall(SYS_set_robust_list, head, len);
+}
+
+static int get_robust_list(int pid, struct robust_list_head **head, size_t *=
len_ptr)
+{
+	return syscall(SYS_get_robust_list, pid, head, len_ptr);
+}
+
+/*
+ * Basic lock struct, contains just the futex word and the robust list eleme=
nt
+ * Real implementations have also a *prev to easily walk in the list
+ */
+struct lock_struct {
+	_Atomic(unsigned int)	futex;
+	struct robust_list	list;
+};
+
+/*
+ * Helper function to spawn a child thread. Returns -1 on error, pid on succ=
ess
+ */
+static int create_child(int (*fn)(void *arg), void *arg)
+{
+	char *stack;
+	pid_t pid;
+
+	stack =3D mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
+	if (stack =3D=3D MAP_FAILED)
+		return -1;
+
+	stack +=3D STACK_SIZE;
+
+	pid =3D clone(fn, stack, CLONE_VM | SIGCHLD, arg);
+
+	if (pid =3D=3D -1)
+		return -1;
+
+	return pid;
+}
+
+/*
+ * Helper function to prepare and register a robust list
+ */
+static int set_list(struct robust_list_head *head)
+{
+	int ret;
+
+	ret =3D set_robust_list(head, sizeof(*head));
+	if (ret)
+		return ret;
+
+	head->futex_offset =3D (size_t) offsetof(struct lock_struct, futex) -
+			     (size_t) offsetof(struct lock_struct, list);
+	head->list.next =3D &head->list;
+	head->list_op_pending =3D NULL;
+
+	return 0;
+}
+
+/*
+ * A basic (and incomplete) mutex lock function with robustness
+ */
+static int mutex_lock(struct lock_struct *lock, struct robust_list_head *hea=
d, bool error_inject)
+{
+	_Atomic(unsigned int) *futex =3D &lock->futex;
+	unsigned int zero =3D 0;
+	pid_t tid =3D gettid();
+	int ret =3D -1;
+
+	/*
+	 * Set list_op_pending before starting the lock, so the kernel can catch
+	 * the case where the thread died during the lock operation
+	 */
+	head->list_op_pending =3D &lock->list;
+
+	if (atomic_compare_exchange_strong(futex, &zero, tid)) {
+		/*
+		 * We took the lock, insert it in the robust list
+		 */
+		struct robust_list *list =3D &head->list;
+
+		/* Error injection to test list_op_pending */
+		if (error_inject)
+			return 0;
+
+		while (list->next !=3D &head->list)
+			list =3D list->next;
+
+		list->next =3D &lock->list;
+		lock->list.next =3D &head->list;
+
+		ret =3D 0;
+	} else {
+		/*
+		 * We didn't take the lock, wait until the owner wakes (or dies)
+		 */
+		struct timespec to;
+
+		to.tv_sec =3D FUTEX_TIMEOUT;
+		to.tv_nsec =3D 0;
+
+		tid =3D atomic_load(futex);
+		/* Kernel ignores futexes without the waiters flag */
+		tid |=3D FUTEX_WAITERS;
+		atomic_store(futex, tid);
+
+		ret =3D futex_wait((futex_t *) futex, tid, &to, 0);
+
+		/*
+		 * A real mutex_lock() implementation would loop here to finally
+		 * take the lock. We don't care about that, so we stop here.
+		 */
+	}
+
+	head->list_op_pending =3D NULL;
+
+	return ret;
+}
+
+/*
+ * This child thread will succeed taking the lock, and then will exit holdin=
g it
+ */
+static int child_fn_lock(void *arg)
+{
+	struct lock_struct *lock =3D arg;
+	struct robust_list_head head;
+	int ret;
+
+	ret =3D set_list(&head);
+	if (ret) {
+		ksft_test_result_fail("set_robust_list error\n");
+		return ret;
+	}
+
+	ret =3D mutex_lock(lock, &head, false);
+	if (ret) {
+		ksft_test_result_fail("mutex_lock error\n");
+		return ret;
+	}
+
+	pthread_barrier_wait(&barrier);
+
+	/*
+	 * There's a race here: the parent thread needs to be inside
+	 * futex_wait() before the child thread dies, otherwise it will miss the
+	 * wakeup from handle_futex_death() that this child will emit. We wait a
+	 * little bit just to make sure that this happens.
+	 */
+	usleep(SLEEP_US);
+
+	return 0;
+}
+
+/*
+ * Spawns a child thread that will set a robust list, take the lock, registe=
r it
+ * in the robust list and die. The parent thread will wait on this futex, and
+ * should be waken up when the child exits.
+ */
+TEST(test_robustness)
+{
+	struct lock_struct lock =3D { .futex =3D 0 };
+	_Atomic(unsigned int) *futex =3D &lock.futex;
+	struct robust_list_head head;
+	int ret, pid, wstatus;
+
+	ret =3D set_list(&head);
+	ASSERT_EQ(ret, 0);
+
+	/*
+	 * Lets use a barrier to ensure that the child thread takes the lock
+	 * before the parent
+	 */
+	ret =3D pthread_barrier_init(&barrier, NULL, 2);
+	ASSERT_EQ(ret, 0);
+
+	pid =3D create_child(&child_fn_lock, &lock);
+	ASSERT_NE(pid, -1);
+
+	pthread_barrier_wait(&barrier);
+	ret =3D mutex_lock(&lock, &head, false);
+
+	/*
+	 * futex_wait() should return 0 and the futex word should be marked with
+	 * FUTEX_OWNER_DIED
+	 */
+	ASSERT_EQ(ret, 0);
+
+	ASSERT_TRUE(*futex & FUTEX_OWNER_DIED);
+
+	wait(&wstatus);
+	pthread_barrier_destroy(&barrier);
+
+	/* Pass only if the child hasn't return error */
+	if (!WEXITSTATUS(wstatus))
+		ksft_test_result_pass("%s\n", __func__);
+}
+
+/*
+ * The only valid value for len is sizeof(*head)
+ */
+TEST(test_set_robust_list_invalid_size)
+{
+	struct robust_list_head head;
+	size_t head_size =3D sizeof(head);
+	int ret;
+
+	ret =3D set_robust_list(&head, head_size);
+	ASSERT_EQ(ret, 0);
+
+	ret =3D set_robust_list(&head, head_size * 2);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	ret =3D set_robust_list(&head, head_size - 1);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	ret =3D set_robust_list(&head, 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+/*
+ * Test get_robust_list with pid =3D 0, getting the list of the running thre=
ad
+ */
+TEST(test_get_robust_list_self)
+{
+	struct robust_list_head head, head2, *get_head;
+	size_t head_size =3D sizeof(head), len_ptr;
+	int ret;
+
+	ret =3D set_robust_list(&head, head_size);
+	ASSERT_EQ(ret, 0);
+
+	ret =3D get_robust_list(0, &get_head, &len_ptr);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(get_head, &head);
+	ASSERT_EQ(head_size, len_ptr);
+
+	ret =3D set_robust_list(&head2, head_size);
+	ASSERT_EQ(ret, 0);
+
+	ret =3D get_robust_list(0, &get_head, &len_ptr);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(get_head, &head2);
+	ASSERT_EQ(head_size, len_ptr);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+static int child_list(void *arg)
+{
+	struct robust_list_head *head =3D arg;
+	int ret;
+
+	ret =3D set_robust_list(head, sizeof(*head));
+	if (ret) {
+		ksft_test_result_fail("set_robust_list error\n");
+		return -1;
+	}
+
+	/*
+	 * After setting the list head, wait until the main thread can call
+	 * get_robust_list() for this thread before exiting.
+	 */
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_wait(&barrier2);
+
+	return 0;
+}
+
+/*
+ * Test get_robust_list from another thread. We use two barriers here to ens=
ure
+ * that:
+ *   1) the child thread set the list before we try to get it from the
+ * parent
+ *   2) the child thread still alive when we try to get the list from it
+ */
+TEST(test_get_robust_list_child)
+{
+	struct robust_list_head head, *get_head;
+	int ret, wstatus;
+	size_t len_ptr;
+	pid_t tid;
+
+	ret =3D pthread_barrier_init(&barrier, NULL, 2);
+	ret =3D pthread_barrier_init(&barrier2, NULL, 2);
+	ASSERT_EQ(ret, 0);
+
+	tid =3D create_child(&child_list, &head);
+	ASSERT_NE(tid, -1);
+
+	pthread_barrier_wait(&barrier);
+
+	ret =3D get_robust_list(tid, &get_head, &len_ptr);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(&head, get_head);
+
+	pthread_barrier_wait(&barrier2);
+
+	wait(&wstatus);
+	pthread_barrier_destroy(&barrier);
+	pthread_barrier_destroy(&barrier2);
+
+	/* Pass only if the child hasn't return error */
+	if (!WEXITSTATUS(wstatus))
+		ksft_test_result_pass("%s\n", __func__);
+}
+
+static int child_fn_lock_with_error(void *arg)
+{
+	struct lock_struct *lock =3D arg;
+	struct robust_list_head head;
+	int ret;
+
+	ret =3D set_list(&head);
+	if (ret) {
+		ksft_test_result_fail("set_robust_list error\n");
+		return -1;
+	}
+
+	ret =3D mutex_lock(lock, &head, true);
+	if (ret) {
+		ksft_test_result_fail("mutex_lock error\n");
+		return -1;
+	}
+
+	pthread_barrier_wait(&barrier);
+
+	/* See comment at child_fn_lock() */
+	usleep(SLEEP_US);
+
+	return 0;
+}
+
+/*
+ * Same as robustness test, but inject an error where the mutex_lock() exits
+ * earlier, just after setting list_op_pending and taking the lock, to test =
the
+ * list_op_pending mechanism
+ */
+TEST(test_set_list_op_pending)
+{
+	struct lock_struct lock =3D { .futex =3D 0 };
+	_Atomic(unsigned int) *futex =3D &lock.futex;
+	struct robust_list_head head;
+	int ret, wstatus;
+
+	ret =3D set_list(&head);
+	ASSERT_EQ(ret, 0);
+
+	ret =3D pthread_barrier_init(&barrier, NULL, 2);
+	ASSERT_EQ(ret, 0);
+
+	ret =3D create_child(&child_fn_lock_with_error, &lock);
+	ASSERT_NE(ret, -1);
+
+	pthread_barrier_wait(&barrier);
+	ret =3D mutex_lock(&lock, &head, false);
+
+	ASSERT_EQ(ret, 0);
+
+	ASSERT_TRUE(*futex & FUTEX_OWNER_DIED);
+
+	wait(&wstatus);
+	pthread_barrier_destroy(&barrier);
+
+	/* Pass only if the child hasn't return error */
+	if (!WEXITSTATUS(wstatus))
+		ksft_test_result_pass("%s\n", __func__);
+	else
+		ksft_test_result_fail("%s\n", __func__);
+}
+
+#define CHILD_NR 10
+
+static int child_lock_holder(void *arg)
+{
+	struct lock_struct *locks =3D arg;
+	struct robust_list_head head;
+	int i;
+
+	set_list(&head);
+
+	for (i =3D 0; i < CHILD_NR; i++) {
+		locks[i].futex =3D 0;
+		mutex_lock(&locks[i], &head, false);
+	}
+
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_wait(&barrier2);
+
+	/* See comment at child_fn_lock() */
+	usleep(SLEEP_US);
+
+	return 0;
+}
+
+static int child_wait_lock(void *arg)
+{
+	struct lock_struct *lock =3D arg;
+	struct robust_list_head head;
+	int ret;
+
+	pthread_barrier_wait(&barrier2);
+	ret =3D mutex_lock(lock, &head, false);
+
+	if (ret) {
+		ksft_test_result_fail("mutex_lock error\n");
+		return -1;
+	}
+
+	if (!(lock->futex & FUTEX_OWNER_DIED)) {
+		ksft_test_result_fail("futex not marked with FUTEX_OWNER_DIED\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Test a robust list of more than one element. All the waiters should wake =
when
+ * the holder dies
+ */
+TEST(test_robust_list_multiple_elements)
+{
+	struct lock_struct locks[CHILD_NR];
+	pid_t pids[CHILD_NR + 1];
+	int i, ret, wstatus;
+
+	ret =3D pthread_barrier_init(&barrier, NULL, 2);
+	ASSERT_EQ(ret, 0);
+	ret =3D pthread_barrier_init(&barrier2, NULL, CHILD_NR + 1);
+	ASSERT_EQ(ret, 0);
+
+	pids[0] =3D create_child(&child_lock_holder, &locks);
+
+	/* Wait until the locker thread takes the look */
+	pthread_barrier_wait(&barrier);
+
+	for (i =3D 0; i < CHILD_NR; i++)
+		pids[i+1] =3D create_child(&child_wait_lock, &locks[i]);
+
+	/* Wait for all children to return */
+	ret =3D 0;
+
+	for (i =3D 0; i < CHILD_NR; i++) {
+		waitpid(pids[i], &wstatus, 0);
+		if (WEXITSTATUS(wstatus))
+			ret =3D -1;
+	}
+
+	pthread_barrier_destroy(&barrier);
+	pthread_barrier_destroy(&barrier2);
+
+	/* Pass only if the child hasn't return error */
+	if (!ret)
+		ksft_test_result_pass("%s\n", __func__);
+}
+
+static int child_circular_list(void *arg)
+{
+	static struct robust_list_head head;
+	struct lock_struct a, b, c;
+	int ret;
+
+	ret =3D set_list(&head);
+	if (ret) {
+		ksft_test_result_fail("set_list error\n");
+		return -1;
+	}
+
+	head.list.next =3D &a.list;
+
+	/*
+	 * The last element should point to head list, but we short circuit it
+	 */
+	a.list.next =3D &b.list;
+	b.list.next =3D &c.list;
+	c.list.next =3D &a.list;
+
+	return 0;
+}
+
+/*
+ * Create a circular robust list. The kernel should be able to destroy the l=
ist
+ * while processing it so it won't be trapped in an infinite loop while hand=
ling
+ * a process exit
+ */
+TEST(test_circular_list)
+{
+	int wstatus;
+
+	create_child(child_circular_list, NULL);
+
+	wait(&wstatus);
+
+	/* Pass only if the child hasn't return error */
+	if (!WEXITSTATUS(wstatus))
+		ksft_test_result_pass("%s\n", __func__);
+}
+
+TEST_HARNESS_MAIN

