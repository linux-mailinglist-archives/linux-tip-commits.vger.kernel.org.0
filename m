Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00EEC1371B3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Jan 2020 16:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgAJPtu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Jan 2020 10:49:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58682 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgAJPtu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Jan 2020 10:49:50 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipwXf-0007XA-7M; Fri, 10 Jan 2020 16:49:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C932D1C2D52;
        Fri, 10 Jan 2020 16:49:42 +0100 (CET)
Date:   Fri, 10 Jan 2020 15:49:42 -0000
From:   "tip-bot2 for Jann Horn" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] x86/vdso: Enable sanitizers for vma.o
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200106200204.94782-1-jannh@google.com>
References: <20200106200204.94782-1-jannh@google.com>
MIME-Version: 1.0
Message-ID: <157867138265.30329.9605534460877020678.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     c29a59e43829beabc4c26036ebcc6a32dd0b6a01
Gitweb:        https://git.kernel.org/tip/c29a59e43829beabc4c26036ebcc6a32dd0b6a01
Author:        Jann Horn <jannh@google.com>
AuthorDate:    Mon, 06 Jan 2020 21:02:04 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 10 Jan 2020 16:47:32 +01:00

x86/vdso: Enable sanitizers for vma.o

The vDSO makefile opts out of all sanitizers (and objtool validation);
however, vma.o is a normal kernel object file (and already has objtool
validation selectively enabled), so turn the sanitizers back on for that
file.

Signed-off-by: Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marco Elver <elver@google.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Link: https://lkml.kernel.org/r/20200106200204.94782-1-jannh@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 0f46273..50a1c90 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -30,6 +30,9 @@ vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
 
 # files to link into kernel
 obj-y				+= vma.o
+KASAN_SANITIZE_vma.o		:= y
+UBSAN_SANITIZE_vma.o		:= y
+KCSAN_SANITIZE_vma.o		:= y
 OBJECT_FILES_NON_STANDARD_vma.o	:= n
 
 # vDSO images to build
