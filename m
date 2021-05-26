Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A273915E5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhEZL0O (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbhEZL0H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:07 -0400
Date:   Wed, 26 May 2021 11:24:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dy6EmtwQZO6i/LEonar5jjKn1gMkfRf6q5Bh5x86Lzk=;
        b=ukZZAqmC2FiBs8UyF+xHsX6kNoBhNR9uQ7IYrfmfgjHqNsyI6aqhZETXTo3rVzaig9wXAJ
        uJymzMzjOfCDwuu0sf/b4OXEWQh1dSZE+1gakaRiKwLLWYQlF1mF56QOqB+4Jgr/uNlnr0
        zAcCV3ouTkG7eMVs3TbY8wPdMD27fJ7Z8Kt9qe37XGHG0O/5j7uOFaSOJKW2xWmuiL2vJ/
        3CTCCblSqJYlhMuzIZUVc0+kCLUcSMaMXkGSfYDRgDzcOBelWl5NA8G6TkoSzkys/WXOOI
        En7pg60qaefI+YsOzSSNQvzmz5ClN1+cfCkvsAmixleDMfvPDrWOqIlKVqPFUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dy6EmtwQZO6i/LEonar5jjKn1gMkfRf6q5Bh5x86Lzk=;
        b=Tsg/ONsBJtThHxQQyhs4TmWgTJb98ELJZJB7+F/1GQ/Vey/QXtnm6PdLVUT19jlzms8yM3
        W7McUNqBsEf9uwDw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: microblaze: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-22-mark.rutland@arm.com>
References: <20210525140232.53872-22-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827433.29796.4233645232080501189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f5b1c0f951e7b0d5634b82d57971cae25a0ba435
Gitweb:        https://git.kernel.org/tip/f5b1c0f951e7b0d5634b82d57971cae25a0ba435
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:51 +02:00

locking/atomic: microblaze: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates microblaze to ARCH_ATOMIC,
using the asm-generic implementations.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-22-mark.rutland@arm.com
---
 arch/microblaze/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 0660f47..5a52922 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -2,6 +2,7 @@
 config MICROBLAZE
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_NO_SWAP
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_GCOV_PROFILE_ALL
