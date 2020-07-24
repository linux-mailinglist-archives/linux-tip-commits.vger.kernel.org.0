Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B66D22CE6F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Jul 2020 21:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGXTJF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 24 Jul 2020 15:09:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39900 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgGXTJE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 24 Jul 2020 15:09:04 -0400
Date:   Fri, 24 Jul 2020 19:08:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595617742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQ8e8jqUAqS++bljw+Nq4gsXBAkwr8JtsHqe6o0P36c=;
        b=R7BCvEhZw/eoCVgo746W/SxnxLFpUjmNphM5KM9t38jLpdP4v5vCuLE4GA3/qnW2NIr5Dg
        bQ/pFbAXqiwsr2b8/IXj1HFL8tRnQ/6uicvGRBGyxR6CKqGFiqdiSFjZI7RBgoo0oQB7nf
        FYB5FjzYXIWcrl7D6NSm4/qIgNcr64az0Qtt7GTGYoRgAKnVbSzeSq240wEP8e8jGszqL7
        shpVW1QfItbS/VCrLMnXWqpcAX4I/ea3XGpoFSnQYo0KGZXEUHnURWlVvWU0+Tc6e3jVHV
        osRAc/pz4CDVtHhGbS0+ubShFFd0STxGMvVb8L+PyRKk36rEa2wghT/Zds9wuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595617742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQ8e8jqUAqS++bljw+Nq4gsXBAkwr8JtsHqe6o0P36c=;
        b=dIS0N77Fwh3s8Dy8zkFZFS10K/pL0XguR5BOxcamQSj4RguJAv7mltaMw44QPBbRZS3Tr2
        +RdZSS2j1aW9cvAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] seccomp: Provide stub for __secure_computing()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220519.404974280@linutronix.de>
References: <20200722220519.404974280@linutronix.de>
MIME-Version: 1.0
Message-ID: <159561773699.4006.1330968938608740876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     6823ecabf03031d610a6c5afe7ed4b4fd659a99f
Gitweb:        https://git.kernel.org/tip/6823ecabf03031d610a6c5afe7ed4b4fd659a99f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 22 Jul 2020 23:59:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 14:59:03 +02:00

seccomp: Provide stub for __secure_computing()

To avoid #ifdeffery in the upcoming generic syscall entry work code provide
a stub for __secure_computing() as this is preferred over
secure_computing() because the TIF flag is already evaluated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200722220519.404974280@linutronix.de


---
 include/linux/seccomp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 4192369..03d28c3 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -61,6 +61,7 @@ struct seccomp_filter { };
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 static inline int secure_computing(void) { return 0; }
+static inline int __secure_computing(void) { return 0; }
 #else
 static inline void secure_computing_strict(int this_syscall) { return; }
 #endif
