Return-Path: <linux-tip-commits+bounces-4175-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD242A5F197
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2A01888E97
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E6926618D;
	Thu, 13 Mar 2025 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cbHgnhP9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iMrIPhyL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F1265CCF;
	Thu, 13 Mar 2025 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863143; cv=none; b=pDwId+Al6WRjMXSHpZhMqmma78qloEaWlO+IVmR1RZ0bE9ZvcJLsrEvgiec7DZvGlkGQawpP/M4wvlvqhSINKzs5rmgQTYf8SkSKia7ZEVKfZLV3l/d2a9T1Dh90AMiJcvmw63ko36AWs/3aQrdD4ev2CTuatXvLCgUxRxuxOxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863143; c=relaxed/simple;
	bh=TzivXsG/NGBs0zhQ8qiGsbyj51VRjseykzDRfC0/pyU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F9n26AjLJ6qdzRKVAIPdFvKN1cRH17PcmH5CRJUTLfwkCAtAmxmHtXqB4fslXt67/vH0v2ohRz9922itnVGeR/JiB+4V7VNjsuAvMTxT1Pe3ZHhd+JFvRHhBW+XsRi62lPlPdlIFhKmzANJu8F+7s4kOXk4T1XuGLfJ27uds33s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cbHgnhP9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iMrIPhyL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 10:52:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741863139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCLlV0qqqs37BI5qq/BhU1RiR9gu+fcSMvoWIOa7yeQ=;
	b=cbHgnhP9sDK6H74SukDMLBn13g/yyPlGtE+UowROueXVltCfL/oPvN6c2YGYcIEhkhcmXA
	8AF7l7yZh7JzcNawbAA/H9ZDyLofpHUEkn/bQtau+HmX1J/EX4DDFtMLURTWOotFBSqUgd
	xqMy0d9NeFP3IhkXDiE0eXPB0pOuRaCLwaIOzi5RCjCfPQQHUP2HeAvFaEGrzVHD5y6yxI
	ReMjyo2RkmB39jLw0QyEcAvuInBOCjUGrN/+nel6A+MOW2uDv3SasUrqCMEr5EaDF3ibnP
	V6xHdz26kXeu6JGYuJ3gMfB4DnUEdRP1PuqaRRX5cDk+he1z9e4dS3ZtiB5LKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741863139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCLlV0qqqs37BI5qq/BhU1RiR9gu+fcSMvoWIOa7yeQ=;
	b=iMrIPhyLoiJv/EDKbYEhfToM1TtMDUT5NHxJQQHMLZgcFjQOB84tBlKkJON0tcTFggWdT/
	5NTslprmFAMwepAw==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clocksource: Remove unnecessary strscpy() size argument
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311110624.495718-2-thorsten.blum@linux.dev>
References: <20250311110624.495718-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186313842.14745.7996578935421128528.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fc661d0a78673f23a3fd78d0bb20900ee64d1839
Gitweb:        https://git.kernel.org/tip/fc661d0a78673f23a3fd78d0bb20900ee64d1839
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Tue, 11 Mar 2025 12:06:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 11:37:44 +01:00

clocksource: Remove unnecessary strscpy() size argument

The size argument of strscpy() is only required when the destination
pointer is not a fixed sized array or when the copy needs to be smaller
than the size of the fixed sized destination array.

For fixed sized destination arrays and full copies, strscpy() automatically
determines the length of the destination buffer if the size argument is
omitted.

This makes the explicit sizeof() unnecessary. Remove it.

[ tglx: Massaged change log ]

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250311110624.495718-2-thorsten.blum@linux.dev

---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 2a7802e..e0eeacb 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1510,7 +1510,7 @@ static int __init boot_override_clocksource(char* str)
 {
 	mutex_lock(&clocksource_mutex);
 	if (str)
-		strscpy(override_name, str, sizeof(override_name));
+		strscpy(override_name, str);
 	mutex_unlock(&clocksource_mutex);
 	return 1;
 }

