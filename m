Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019D22B6C7D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Nov 2020 19:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgKQSDL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Nov 2020 13:03:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49750 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgKQSDK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Nov 2020 13:03:10 -0500
Date:   Tue, 17 Nov 2020 18:03:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605636188;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dzZ0aEGs6coGOHgitGQejdWgR+Ek+i4gwJADmHs3gmU=;
        b=w9pcLThFGP4coG6dwg2iiLbSL3hU1eDAb+2ic3mY0Vo1zfyRTBUmZDm25qwpddYWbVekKT
        nT4aHlHQFmq7hsenwccG6S/Hj8thjIMlntdu/A+/ImITav/dXtW0zR5BTwmO+Oi0GkiZ1q
        jXE1H8Drv29KZYD506WWAUZ74A1OdvI/4XKsMiqUa7FTL+STwp8m4CbcFFww9axCsqFtgk
        0gdEE/rpRS02mWRo2Ncbabr+3soLFnS6HY/i3eUcxNtgNR5q2Gh5AZnY3kqWdKylte4z32
        Y1fZQyWfr64h1MnGOaSq5M3414ZidGv3TLx7RyLKCSIXRMbReCbAmNyf/sjYlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605636188;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dzZ0aEGs6coGOHgitGQejdWgR+Ek+i4gwJADmHs3gmU=;
        b=MudrgGoZfg2PXVizIq1p0ec/wcEWAnb7yqfHR/09eJteVEAYWHMgyQHJ7u0SzJtTQI5rp0
        z7cL75Pwu++3RXCw==
From:   "tip-bot2 for Chester Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] arm64/ima: add ima_arch support
Cc:     Chester Lin <clin@suse.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160563618769.11244.6834590867933252385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     8d39cee0592e0129280e5a3cc480d64649c5e63f
Gitweb:        https://git.kernel.org/tip/8d39cee0592e0129280e5a3cc480d64649c5e63f
Author:        Chester Lin <clin@suse.com>
AuthorDate:    Fri, 30 Oct 2020 14:08:40 +08:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 17 Nov 2020 15:09:32 +01:00

arm64/ima: add ima_arch support

Add arm64 IMA arch support. The code and arch policy is mainly inherited
from x86.

Co-developed-by: Chester Lin <clin@suse.com>
Signed-off-by: Chester Lin <clin@suse.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f858c35..04e78a3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1849,6 +1849,7 @@ config EFI
 	select EFI_RUNTIME_WRAPPERS
 	select EFI_STUB
 	select EFI_GENERIC_STUB
+	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
 	default y
 	help
 	  This option provides support for runtime services provided
