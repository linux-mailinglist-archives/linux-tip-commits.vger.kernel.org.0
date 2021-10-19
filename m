Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD09433AA7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Oct 2021 17:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhJSPhy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Oct 2021 11:37:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46514 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbhJSPhx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Oct 2021 11:37:53 -0400
Date:   Tue, 19 Oct 2021 15:35:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634657740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yYKrNslr4n4Ev6Uakrnm4s49w7Rx+6oai8+nZHfs5aY=;
        b=gb36J6FqtZk4UtMHmATjT28WIoJo5PZGfjbZ32hhhcPhA6N+vRcGD6D0rGjBSpxMaViy+7
        V52IvSeaqp6zBc30shlF97I7R1EfJz6snw8YFV6Yim3gKupd9EioKAPVGrAl3KZXx9ix2T
        tQlq949eQL2fTuWNWo2NMcS486Mx6U0S0lhQsmQQirf9CklFsU5ChOKYaAoHTeWnGkn7rQ
        +5DtGtSPvtUBncFkyEf1SanlrlQ9e4vGG77IjSxh9CHM6QwjVoSMM8T+Za2QOJwb5TdAOl
        VTOb5K3drNZwQE/493KRekN7WmKaOPCeXx6zMYiVLlDii6JV6rEt1EFn6BenIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634657740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yYKrNslr4n4Ev6Uakrnm4s49w7Rx+6oai8+nZHfs5aY=;
        b=zzROBXy+5gH2ZfDJyqg+5NmzniwLHOL99UESlR79odBVIBUb581RPHlxiM0rEmSh46I1j8
        qQHpy/e11WmFHdAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Fix PREEMPT_RT build
Cc:     Mike Galbraith <efault@gmx.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163465773939.25758.12131769079594447789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4d38167330910ddb15b1add5b5cef835677a29fd
Gitweb:        https://git.kernel.org/tip/4d38167330910ddb15b1add5b5cef835677a29fd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 15 Oct 2021 12:05:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Oct 2021 17:27:05 +02:00

futex: Fix PREEMPT_RT build

Mike reported that rcuwait went walk-about and is causing failures on
the PREEMPT_RT builds, restore it.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/futex.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 948fcf3..040ae42 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -5,6 +5,10 @@
 #include <linux/futex.h>
 #include <linux/sched/wake_q.h>
 
+#ifdef CONFIG_PREEMPT_RT
+#include <linux/rcuwait.h>
+#endif
+
 #include <asm/futex.h>
 
 /*
