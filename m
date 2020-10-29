Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6B429E915
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgJ2Kfv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:35:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60616 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgJ2Kfv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:35:51 -0400
Date:   Thu, 29 Oct 2020 10:35:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603967749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+b7IrgS+Jh4kwmAGNtuWQVeZtI5K/CTvSja+jadtGxw=;
        b=uX5LNukNz6RNYn5XLujtwxQ5bFAqe5Lrm/3O2+eDvOWA9NkwKqKPUvJKz7wLwZrkum5U1N
        eDW8DUGo5GIo7JD6lQYkAbRAfDqHal5uWRlGBOnScZvZyRntB51gV44qSpQWoMGjj2H+Wf
        s4T7/3pY1ySbYkK+CHqKWGSTuZMDec7gFi6iL19YP1JjSyvUm4Yu2PXuHHu5OA/NzqNpF4
        24ySTx9rlBTcJZHsh7+gmzgHp8Q8hj11EGr6+0FO0T40+9KL9IUvYQfzJ7Xm8qqag4RP06
        Wm/ROenNM8zavG6to6n7UH/skbxxewlM03EXub6tAAuqIlDDY9tDJ5I7Kwvmbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603967749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+b7IrgS+Jh4kwmAGNtuWQVeZtI5K/CTvSja+jadtGxw=;
        b=birQb4B4Mmd72/Vte/SQQ2vj0O5YHpS4rDPVfMbrTDIyZi7y+lhC3H7XM0G+niXGlK855L
        2VKiaWAafnYIH+DQ==
From:   "tip-bot2 for Jens Axboe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86: Wire up TIF_NOTIFY_SIGNAL
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201026203230.386348-4-axboe@kernel.dk>
References: <20201026203230.386348-4-axboe@kernel.dk>
MIME-Version: 1.0
Message-ID: <160396774828.397.17300041063164056349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     c8d5ed67936fddbe2ae845fc80397718006322d7
Gitweb:        https://git.kernel.org/tip/c8d5ed67936fddbe2ae845fc80397718006322d7
Author:        Jens Axboe <axboe@kernel.dk>
AuthorDate:    Mon, 26 Oct 2020 14:32:29 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 29 Oct 2020 11:29:51 +01:00

x86: Wire up TIF_NOTIFY_SIGNAL

The generic entry code has support for TIF_NOTIFY_SIGNAL already. Just
provide the TIF bit.

[ tglx: Adopted to other TIF changes in x86 ]

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201026203230.386348-4-axboe@kernel.dk

---
 arch/x86/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index a12b964..06a1710 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -91,6 +91,7 @@ struct thread_info {
 #define TIF_NEED_FPU_LOAD	14	/* load FPU on return to userspace */
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
+#define TIF_NOTIFY_SIGNAL	17	/* signal notifications exist */
 #define TIF_SLD			18	/* Restore split lock detection on context switch */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
@@ -118,6 +119,7 @@ struct thread_info {
 #define _TIF_NEED_FPU_LOAD	(1 << TIF_NEED_FPU_LOAD)
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
+#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
