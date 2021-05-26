Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08ED93915E7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhEZL0P (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhEZL0G (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB7C061574;
        Wed, 26 May 2021 04:24:35 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AzH8Y0lpVEGgrzTu/OFcCLqKskV1bnV9RR+IWd+B038=;
        b=rYOHKq/4Kpyr3K1Aq5++V4FZTwYmWHtCpU4Es+aYhNK0fQYJVm4+nshuRGtVukdlRJrE+a
        cqIdMzYgKLAG5CYNdcNn0ztLlvMVqhHjpDGmKjXW8eok6BJpspb5qhAmIDqmSoWp/A7m+H
        FWUSfYQ/4C1uxnn842RAZvl6RuVJNTm4Qf0tItSxXLUBgsDz7vdAVZ7gh8QhMRGCBgnMYV
        tQ2ACKxYslqcoHF4ALr/yoGdK1TEq2wgkrH/peFhluWEW2rWmiaCdOrDwPAlgWmOHtjDNg
        m/JQ967G2m82ntErUVR5Os2l3fSb3i+vt34m9YCmrGtQkPpYnRSnPuavXEILyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AzH8Y0lpVEGgrzTu/OFcCLqKskV1bnV9RR+IWd+B038=;
        b=ovReR8eETNDhUXtDbqQ87BWA3aBhdIQHjW8cV+oZE/1VLoYCAqXdqq9GWZxIRri3Yd9YXl
        HRzHiwS+9zpHg+Bw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: nios2: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-25-mark.rutland@arm.com>
References: <20210525140232.53872-25-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827284.29796.10068597356526604118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7e517b4c11200be3b0a941b33b26798a5e808dbc
Gitweb:        https://git.kernel.org/tip/7e517b4c11200be3b0a941b33b26798a5e808dbc
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:51 +02:00

locking/atomic: nios2: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates nios2 to ARCH_ATOMIC, using
the asm-generic implementations.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-25-mark.rutland@arm.com
---
 arch/nios2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index c24955c..67dae88 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -2,6 +2,7 @@
 config NIOS2
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
