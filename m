Return-Path: <linux-tip-commits+bounces-1909-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD09458BC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 09:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70BC1C209F6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 07:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027671BF317;
	Fri,  2 Aug 2024 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LIUhvIeR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CY1ldcZV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661B71BE875;
	Fri,  2 Aug 2024 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583728; cv=none; b=RDLDIuSXZjRFOFdQrop87nepqTS99zsaGGcBHgK3B7gA5lC+NTksQqUnZsGT8byhO4NC2DPCipuo02V5eidVlosUqO+GMsPKfZ+VibQVLDribNJrV09krhaU1yeeesVlYHM+R5qCDdFGzPgPJqg+uDCfWvSj2f3XWMYEPU7/Nz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583728; c=relaxed/simple;
	bh=ZjXjzJYk18pmdjRxj7z9OklgFa4Rt6fOSO1FTl4KjbI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u1WBJ0GkE1xcSNluC8p/W8ulRKxPnulyOjznvbqjW/HXtDE+s2HJMKkedjngYXNdWQQFAR720AEqs9Sm3HiBrzgjSiyipg6L00+JR9lY0hqpK7o0KJPXn6WgaHKCeuNtSD1AwAN9pKeDqWJFoEBtnz4flo9IcNTKl2isGR/QYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LIUhvIeR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CY1ldcZV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 07:28:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722583725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8PAnLzG+L401L3pFv6Z6z7acKfk7xuWS0J2+z5/eeI=;
	b=LIUhvIeRHN8GRRGWqyUdRAt+SN80g76xy18iFRZG0vH8BqxZSIsWl/aIrvqOO1de3RddxX
	XAnkeea/bTux8GVgL8ip+mEBTd4s63CD0svE8+ckn98cZvJte9HJwofogN74vw2eMX64Xm
	FSMDxSO2AzkmqflN1fZ36kRE5fjWErluaDxDvkvfUINa2IeCfhFG0Dn8IajKcLoC4hEkH1
	E1FqtoWBT+HSjn0B2LUmK9vsHtZp6xYw1hbmM0RPApiwSOgpa0nCFWBFC5eTZON7oiUFQ2
	K7DD3HgWkb68+Z2CWOl+3v8gVJ2zoX/Sp6gf/P1rhvcVyHI4YN1/Xb4r3xwf3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722583725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8PAnLzG+L401L3pFv6Z6z7acKfk7xuWS0J2+z5/eeI=;
	b=CY1ldcZVrFKF+LKklJGuWV1B7MY2RlS8rprWl7ta1NKHMMJWM7C6kbhZz+K4ew7RRSk4Mw
	cu1Z86cGpGZ+9yBQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Strip bitfield names
 leading/trailing whitespace
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240718134755.378115-6-darwi@linutronix.de>
References: <20240718134755.378115-6-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172258372520.2215.2625975190952358820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     9ecbc60a5ede928abdd2b152d828ae0ea8a1e3ed
Gitweb:        https://git.kernel.org/tip/9ecbc60a5ede928abdd2b152d828ae0ea8a1e3ed
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 18 Jul 2024 15:47:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 09:17:19 +02:00

tools/x86/kcpuid: Strip bitfield names leading/trailing whitespace

While parsing and saving bitfield names from the CSV file, an extra
leading space is copied verbatim.  That extra space is not a big issue
now, but further commits will add a new CSV file with much more padding
for the bitfield's name column.

Strip leading/trailing whitespaces while saving bitfield names.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240718134755.378115-6-darwi@linutronix.de

---
 tools/arch/x86/kcpuid/kcpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 581d28c..c4f0ace 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -379,7 +379,7 @@ static int parse_line(char *line)
 	if (start)
 		bdesc->start = strtoul(start, NULL, 0);
 
-	strcpy(bdesc->simp, tokens[4]);
+	strcpy(bdesc->simp, strtok(tokens[4], " \t"));
 	strcpy(bdesc->detail, tokens[5]);
 	return 0;
 

