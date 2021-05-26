Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909133915E4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhEZL0N (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54580 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhEZL0F (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:05 -0400
Date:   Wed, 26 May 2021 11:24:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40SBaBOSjWUrIb9Aqlvw3AVhUdjdBw7sEmDK0ZOZr+w=;
        b=rCQ2VpaErs808mpyyLqbvO0ZAFrCw7zSRgZdgqw63Wfue31Ju6tAgcVl/tpCpOK16bX0mf
        8lFP+RR7MZelGl4PJOpfqvCOjFYUSLZDcQT1lyyeU8V/2aaObBGl217Tc+Hbn6PMKNYmod
        w3aqGXGYDav6uIg//PuF/0DuochDCgbqewewyU5bax2p+sxMZJ2zUU/vUDy85yFY+5wxOd
        wBIjEQxpequNyRocfc6w6Ox4OcJQKNhvLsADLfHzFZ+FyaQ7E54b2qnKXe3B/1F4qu/WP9
        5R1bkP7T+F/dmGX3A8aCycVip+vKrNmrz3ktLvgEx3pUAyeG7NV0xnbXTHTh6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40SBaBOSjWUrIb9Aqlvw3AVhUdjdBw7sEmDK0ZOZr+w=;
        b=SLAUPJjR7X+HWmAdOPNGfkaUhncTS+l27RGBIZzmo0ftikW94VwtDA86wXVeJ2iSKHmOcH
        yJSAbgXbNUDmOSAA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: nds32: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Greentime Hu <green.hu@gmail.com>,
        Nick Hu <nickhu@andestech.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Chen <deanbo422@gmail.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-24-mark.rutland@arm.com>
References: <20210525140232.53872-24-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827328.29796.6710390799103347726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0cc70f54ee4394b49608f0aaee50c2b4109c3be6
Gitweb:        https://git.kernel.org/tip/0cc70f54ee4394b49608f0aaee50c2b4109c3be6
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:51 +02:00

locking/atomic: nds32: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates nds32 to ARCH_ATOMIC, using
the asm-generic implementations.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-24-mark.rutland@arm.com
---
 arch/nds32/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 6231390..3529135 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -7,6 +7,7 @@
 config NDS32
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
