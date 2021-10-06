Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D692423FC8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Oct 2021 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhJFOIR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Oct 2021 10:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhJFOIR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Oct 2021 10:08:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E9C061749;
        Wed,  6 Oct 2021 07:06:24 -0700 (PDT)
Date:   Wed, 06 Oct 2021 14:06:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633529182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpvHo2Y2KsjutoZlX42eUKKgHxQ5So7ziBtaVQFP3p8=;
        b=kKoKE/ARicY89ER3vM3DK7z9yF78JUgxTbODSQBfOzdqXGNAAW/rsaqEjEkfXNUzRIKybP
        mRQRODgcuXKBttfjmc8/m8fj6yphPlCj1jl7nRq3Ii13+XaLyqwq0WS4g2M/FPBYhBpp6R
        00QPQbXQkgcRakTMayg0bjenV5vttzY6U+SGy494nNj3ECe0cgnYAWY8jzJqXv/5QeHYb1
        N29Fm9M6exPXTZ99xvLBXmOcWxsSBYcfivcplF3Ix9FfptlHicv0/h1+pju9YMEWULXpeH
        G68rquZAPLhblXb+mILmKX8FrYu2X3mrCNP6sUaMY5pzJRmxq/fVh+V+YDjUpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633529182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpvHo2Y2KsjutoZlX42eUKKgHxQ5So7ziBtaVQFP3p8=;
        b=ctEHCAMnuCjtj5qQ+QbTfXFWK11aliIe+kXgWYehCe26qEc68dImfcknFe8+Ddng8g7fHk
        GolibzuXsAivhJCQ==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/Kconfig: Remove references to obsolete
 Kconfig symbols
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803113531.30720-5-lukas.bulwahn@gmail.com>
References: <20210803113531.30720-5-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <163352918158.25758.16985793386110673881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3fd3590b53d1462ab534523e8d9ebdebd9b55f79
Gitweb:        https://git.kernel.org/tip/3fd3590b53d1462ab534523e8d9ebdebd9b55f79
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Tue, 03 Aug 2021 13:35:26 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 05 Oct 2021 21:36:58 +02:00

x86/Kconfig: Remove references to obsolete Kconfig symbols

Remove two symbols referenced in Kconfig which have been removed
previously by:

  ef3c67b6454b ("mfd: intel_msic: Remove driver for deprecated platform")
  1b79fc4f2bfd ("x86/apb_timer: Remove driver for deprecated platform")

Detected by scripts/checkkconfigsymbols.py.

  [ bp: Merge into a single patch. ]

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210803113531.30720-5-lukas.bulwahn@gmail.com
---
 arch/x86/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4e001bb..b79e88e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -605,9 +605,7 @@ config X86_INTEL_MID
 	depends on X86_IO_APIC
 	select I2C
 	select DW_APB_TIMER
-	select APB_TIMER
 	select INTEL_SCU_PCI
-	select MFD_INTEL_MSIC
 	help
 	  Select to build a kernel capable of supporting Intel MID (Mobile
 	  Internet Device) platform systems which do not have the PCI legacy
