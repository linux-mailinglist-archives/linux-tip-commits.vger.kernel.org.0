Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E179311095
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Feb 2021 20:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhBERRm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 5 Feb 2021 12:17:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49558 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBERQW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 5 Feb 2021 12:16:22 -0500
Date:   Fri, 05 Feb 2021 18:58:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612551483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThxGWeqsK4d0OgDaQKX6wTkCCqd4OEQOPXa8W7M8KMI=;
        b=lmqkb90yslJwUq6k9d3C+9W1tAXghnftslInu/5XiO8mSL66QnyNsDeaxtMcLuut3yE2BG
        b6ocl4nR1cNYikicFujClRmLmXiJ7eMO0tORE4iot8hB0d3T37quGS7cr3RmdHVqVdpNaY
        kYEu6vDUqoeF4D592bJBlgstNz3Ib6XpN5rnwnZeI1Xm1m989RNGQ2+DsRGBAPjHZsm2cp
        yKuUsTC8vCj7leduNosct5NWv94SAvv3LATIVvX5t9nw7O6gZuexFhZgpTQsnpBgsnxKq6
        38K2mI/tdXwmSLKeA5asLRAhpZqwh2rIHLS2FUD42uxTs8KsfwBrNSNjCPEK+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612551483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThxGWeqsK4d0OgDaQKX6wTkCCqd4OEQOPXa8W7M8KMI=;
        b=OmJcRQZ3u5CW2iQZG78S78PCvQhgme65eshriqGTihyxxXDHJwdiCXCpMohF8gFMszjVj3
        lp4TohkwvcVOuxCg==
From:   "tip-bot2 for Anand K Mistry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/Kconfig: Remove HPET_EMULATE_RTC depends on RTC
Cc:     Anand K Mistry <amistry@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210204183205.1.If5c6ded53a00ecad6a02a1e974316291cc0239d1@changeid>
References: <20210204183205.1.If5c6ded53a00ecad6a02a1e974316291cc0239d1@changeid>
MIME-Version: 1.0
Message-ID: <161255148297.23325.11250667185160852143.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3228e1dc80983ee1f5d2e533d010b3bd8b50f0e2
Gitweb:        https://git.kernel.org/tip/3228e1dc80983ee1f5d2e533d010b3bd8b50f0e2
Author:        Anand K Mistry <amistry@google.com>
AuthorDate:    Thu, 04 Feb 2021 18:32:32 +11:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 05 Feb 2021 19:56:35 +01:00

x86/Kconfig: Remove HPET_EMULATE_RTC depends on RTC

The RTC config option was removed in commit f52ef24be21a ("rtc/alpha:
remove legacy rtc driver")

Signed-off-by: Anand K Mistry <amistry@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20210204183205.1.If5c6ded53a00ecad6a02a1e974316291cc0239d1@changeid
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7b6dd10..865c1e7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -889,7 +889,7 @@ config HPET_TIMER
 
 config HPET_EMULATE_RTC
 	def_bool y
-	depends on HPET_TIMER && (RTC=y || RTC=m || RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)
+	depends on HPET_TIMER && (RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)
 
 config APB_TIMER
 	def_bool y if X86_INTEL_MID
