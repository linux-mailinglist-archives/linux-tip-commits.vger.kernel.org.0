Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F89122C5CF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Jul 2020 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGXNKb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 24 Jul 2020 09:10:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38116 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGXNKb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 24 Jul 2020 09:10:31 -0400
Date:   Fri, 24 Jul 2020 13:10:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595596229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yNAycmSVcZT0Mky2S23YQykAtqrpZVnbnF3k8dnxZlM=;
        b=gLIIckYSyqGUg5gW2Oa2Nll7qc0HUAQ8gBTV1qYUp/om99V1DQ7X14WTOZnAN0qXdWKNpU
        r02RioIYdPKJjzsaaiR432HgQTv3Y6FHgUloEenPoOkCK/0PQVVEM5XmGFEHEqQZ1nyv2y
        E67wMKfoRj/ohLdoGDdhlawIZp72DWpEZMGgcNaNCgEIh4hvJMdyYFetGlPT+U4LvDpOkw
        ReCCSsJ+HUcbrz2c6xQcfOZZ+0N1FNyRr+JwpDMjKwnHvEWyRduiQzZlm0eah9gGHg5vhe
        oMVKJrVhgxMIWX438w2XheMFR2ZrQwk6pLbVZt7Ti0BwJig5cjwZoN4OtCiPYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595596229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yNAycmSVcZT0Mky2S23YQykAtqrpZVnbnF3k8dnxZlM=;
        b=3hZ18Njdiq09aydCh8XEgusfaSbphb8Yj/OtLPlR0Z5Mw4AxObAyKd8UhGLZzAXXuiseoL
        +cMs0AWDwTDNkhDg==
From:   "tip-bot2 for Sedat Dilek" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/defconfigs: Remove CONFIG_CRYPTO_AES_586 from
 i386_defconfig
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723171119.9881-1-sedat.dilek@gmail.com>
References: <20200723171119.9881-1-sedat.dilek@gmail.com>
MIME-Version: 1.0
Message-ID: <159559622819.4006.8469899009265842837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     6526b12de07588253a52577f42ec99fc7ca26a1f
Gitweb:        https://git.kernel.org/tip/6526b12de07588253a52577f42ec99fc7ca26a1f
Author:        Sedat Dilek <sedat.dilek@gmail.com>
AuthorDate:    Thu, 23 Jul 2020 19:11:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 24 Jul 2020 14:55:55 +02:00

x86/defconfigs: Remove CONFIG_CRYPTO_AES_586 from i386_defconfig

Initially CONFIG_CRYPTO_AES_586=y was added to the i386_defconfig file in:

  c1b362e3b4d3: ("x86: update defconfigs")

The code and Kconfig for CONFIG_CRYPTO_AES_586 was removed in:

  1d2c3279311e: ("crypto: x86/aes - drop scalar assembler implementations")

Remove the leftover from the i386_defconfig file as well.

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20200723171119.9881-1-sedat.dilek@gmail.com
---
 arch/x86/configs/i386_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 5509045..3a2a898 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -290,7 +290,6 @@ CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
-CONFIG_CRYPTO_AES_586=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_EFI_STUB=y
 CONFIG_ACPI_BGRT=y
