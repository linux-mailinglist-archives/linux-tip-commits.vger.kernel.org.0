Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977014278AB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbhJIKJD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244411AbhJIKJB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B24C061570;
        Sat,  9 Oct 2021 03:07:04 -0700 (PDT)
Date:   Sat, 09 Oct 2021 10:06:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAVJicna/b7C2WGjjGSmvD9XEwNO08BcYAxnu1bhB4A=;
        b=qNXbMDhOLyCTcLxugNHuU6pEj4b2sAb+xWlhudLDd7QYcTMmT/7J+upyKxNnnXtkJLOKcI
        1A5Aez39IAN5wQs0D6LEGqHqYN+pt5/rlnrPlWVknJds1gXmLO0ibMbAQCTqAkghxviPvH
        6Y8G6/6iKnTGRND7vdKJXySqPsYRa8WoxGeWmySUpn6o42iEyvpDxA5U1kSelxH21LVaxi
        oWPrGjbJUBvaWGKzhdpEKpfYDYFiOpDw+ssSD3xq5So1zN7Z4AJ/R7JkcrpnS4sU4+QZtl
        pGZN1KA42MEZYa40OuGVOtY56zm6HqejksgISu+/RDr5Y257ib/uk/DrHvsyHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAVJicna/b7C2WGjjGSmvD9XEwNO08BcYAxnu1bhB4A=;
        b=s98zpnWn3qR5S7R+BqWrxdMlfUBZShn3PPh24yqqKuyTARsPlgzBht8FiXqs4oC+a8m0WT
        YSSmLxFyfLwtPqBA==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex2: Documentation: Document sys_futex_waitv() uAPI
Cc:     andrealmeid@collabora.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-23-andrealmeid@collabora.com>
References: <20210923171111.300673-23-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377401910.25758.10428842079103776202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     dd0aa2cd2e9e3e49b8c3b43924dc1a1d4e22b4d1
Gitweb:        https://git.kernel.org/tip/dd0aa2cd2e9e3e49b8c3b43924dc1a1d4e2=
2b4d1
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Thu, 23 Sep 2021 14:11:11 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:13 +02:00

futex2: Documentation: Document sys_futex_waitv() uAPI

Create userspace documentation for futex_waitv() syscall, detailing how
the arguments are used.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210923171111.300673-23-andrealmeid@collabor=
a.com
---
 Documentation/userspace-api/futex2.rst | 86 +++++++++++++++++++++++++-
 Documentation/userspace-api/index.rst  |  1 +-
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/userspace-api/futex2.rst

diff --git a/Documentation/userspace-api/futex2.rst b/Documentation/userspace=
-api/futex2.rst
new file mode 100644
index 0000000..9693f47
--- /dev/null
+++ b/Documentation/userspace-api/futex2.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D
+futex2
+=3D=3D=3D=3D=3D=3D
+
+:Author: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
+
+futex, or fast user mutex, is a set of syscalls to allow userspace to create
+performant synchronization mechanisms, such as mutexes, semaphores and
+conditional variables in userspace. C standard libraries, like glibc, uses it
+as a means to implement more high level interfaces like pthreads.
+
+futex2 is a followup version of the initial futex syscall, designed to overc=
ome
+limitations of the original interface.
+
+User API
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+``futex_waitv()``
+-----------------
+
+Wait on an array of futexes, wake on any::
+
+  futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
+              unsigned int flags, struct timespec *timeout, clockid_t clocki=
d)
+
+  struct futex_waitv {
+        __u64 val;
+        __u64 uaddr;
+        __u32 flags;
+        __u32 __reserved;
+  };
+
+Userspace sets an array of struct futex_waitv (up to a max of 128 entries),
+using ``uaddr`` for the address to wait for, ``val`` for the expected value
+and ``flags`` to specify the type (e.g. private) and size of futex.
+``__reserved`` needs to be 0, but it can be used for future extension. The
+pointer for the first item of the array is passed as ``waiters``. An invalid
+address for ``waiters`` or for any ``uaddr`` returns ``-EFAULT``.
+
+If userspace has 32-bit pointers, it should do a explicit cast to make sure
+the upper bits are zeroed. ``uintptr_t`` does the tricky and it works for
+both 32/64-bit pointers.
+
+``nr_futexes`` specifies the size of the array. Numbers out of [1, 128]
+interval will make the syscall return ``-EINVAL``.
+
+The ``flags`` argument of the syscall needs to be 0, but it can be used for
+future extension.
+
+For each entry in ``waiters`` array, the current value at ``uaddr`` is compa=
red
+to ``val``. If it's different, the syscall undo all the work done so far and
+return ``-EAGAIN``. If all tests and verifications succeeds, syscall waits u=
ntil
+one of the following happens:
+
+- The timeout expires, returning ``-ETIMEOUT``.
+- A signal was sent to the sleeping task, returning ``-ERESTARTSYS``.
+- Some futex at the list was woken, returning the index of some waked futex.
+
+An example of how to use the interface can be found at ``tools/testing/selft=
ests/futex/functional/futex_waitv.c``.
+
+Timeout
+-------
+
+``struct timespec *timeout`` argument is an optional argument that points to=
 an
+absolute timeout. You need to specify the type of clock being used at
+``clockid`` argument. ``CLOCK_MONOTONIC`` and ``CLOCK_REALTIME`` are support=
ed.
+This syscall accepts only 64bit timespec structs.
+
+Types of futex
+--------------
+
+A futex can be either private or shared. Private is used for processes that
+shares the same memory space and the virtual address of the futex will be the
+same for all processes. This allows for optimizations in the kernel. To use
+private futexes, it's necessary to specify ``FUTEX_PRIVATE_FLAG`` in the fut=
ex
+flag. For processes that doesn't share the same memory space and therefore c=
an
+have different virtual addresses for the same futex (using, for instance, a
+file-backed shared memory) requires different internal mechanisms to be get
+properly enqueued. This is the default behavior, and it works with both priv=
ate
+and shared futexes.
+
+Futexes can be of different sizes: 8, 16, 32 or 64 bits. Currently, the only
+supported one is 32 bit sized futex, and it need to be specified using
+``FUTEX_32`` flag.
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-=
api/index.rst
index c432be0..a61eac0 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -28,6 +28,7 @@ place where this information is gathered.
    media/index
    sysfs-platform_profile
    vduse
+   futex2
=20
 .. only::  subproject and html
=20
