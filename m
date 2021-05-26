Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D833915ED
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhEZL0T (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54708 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbhEZL0I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:08 -0400
Date:   Wed, 26 May 2021 11:24:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028276;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi5PN/AyYv/B/k/S+mfmdarDIBRRtwcnE7RWYPEu5X4=;
        b=A+aE3uuS6GO/7W9mJuvrPpxTD2nemdzc9ERfyidqrRU75bPRmQf9RoTkF1gdC90kzT0+6l
        KL+lPLoUbYLZ369TocBv7eCCyllCv0z7X1eTI77hyJzz9BRdURxBDdaAocmzXzSrLH9X7H
        w+0lDmRC7h7HE+/8Jtcd8MAnrqvi8xIP1wBR50+XkBJeDJH3sKo8kToGyf867sT6tejv85
        6G/MDqEIor7DvZGU1A2Nq2l2QqCaLnBzpaNnS8xjbArn8ajntWGUoIAdls8ReDD4PtoNRH
        0d/juGCrDyUzw1YwQHNjPqGTR2SH/IrnVd2k9PQ6GnBhLddiiy17zoaTYLMyuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028276;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi5PN/AyYv/B/k/S+mfmdarDIBRRtwcnE7RWYPEu5X4=;
        b=g2qWbbnsXbvQ240q5P/ytDNOwVR7Ruz3PCRDeObXey2FdBHAZZz/OaECdVbuHxYnmpwS2F
        y4ibO5AnUC0efpAQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: h8300: move to ARCH_ATOMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-18-mark.rutland@arm.com>
References: <20210525140232.53872-18-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202827611.29796.6417676811148315341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c879c39ebc3a9bea280675840d623a40b4636c80
Gitweb:        https://git.kernel.org/tip/c879c39ebc3a9bea280675840d623a40b4636c80
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:51 +02:00

locking/atomic: h8300: move to ARCH_ATOMIC

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates h8300 to ARCH_ATOMIC, using
the asm-generic implementations.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-18-mark.rutland@arm.com
---
 arch/h8300/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 3e3e0f1..bdf05ad 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -2,6 +2,7 @@
 config H8300
         def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select BINFMT_FLAT_OLD_ALWAYS_RAM
