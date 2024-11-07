Return-Path: <linux-tip-commits+bounces-2824-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA129C0CD1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 18:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078021F2117D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 17:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB94018DF62;
	Thu,  7 Nov 2024 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+I+pZ+V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="87VveMgv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C4DDBE;
	Thu,  7 Nov 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000235; cv=none; b=unxnIFqvGnwxcxG1xKxi/HAN5xLQMGqzSiA9jc/vGdExzrIkbCxMpjmfuJDLsZIgEf/crs9G52pcQ/HCKYx/2B+Hpq5147RsANfKp3sXuxmnxfqDPaivbE9IasvPIEImdb22DUdgE+PqYg0J84tk+ZOjpjbrPNT4iT/Be793zuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000235; c=relaxed/simple;
	bh=49QShnwTvXfWfDU9BGK8+qb5vHln/TObeiAd4Y4FZ9M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PfFhwE6FXrrNReTtbXaA+9gRl5cMaovOOsboGovQmnTlLs783VVIRL6AKybukI0oJB7+MtajYnD8Nzf2RyEW3wFScue/Vaqzjr+fI0hgjJxrpV6VXpfh6O6p+m7nCF800fkw4Pt5nWRrggweEW4n+04lqy69PHg8AqU/fhbHt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+I+pZ+V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=87VveMgv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 17:23:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731000232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCSBGhstiht1T/Sfc+x1rHpc8E4QZNBzT7UKq50dECg=;
	b=0+I+pZ+VAb2QGqTDn2JMeFECJY5jkKztJdpU0AEnUexGMiRG1637peGw3oJBH5/z/qkp0H
	A2+zmGs1aqFoZJCees0A6AQy80ooeNSKQaSDS08Z+BfW+gDDUFotaqvKLUYCE3gR19ErZl
	YPVaYuSecqxmlgDQqnyy1nc/MnASejzegj6Gz+crK6qMSF3iQF0lgQ8T0ZPeWP3giJ6buK
	/AJXt5qvzSPogPWQOoPCwA9SqylM9rxc6IKyVUiuMoDjGgOhWcTJ9d0A5Hx5Ivpt1Uvk3y
	KhXuLP1GzXpzlj/R9wMBXva98c4QfJDRUYzcKKys8tp+ql+cR0ByM3IT9azOvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731000232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCSBGhstiht1T/Sfc+x1rHpc8E4QZNBzT7UKq50dECg=;
	b=87VveMgvNZvwjmuJZLsl4iVB6DXjKo7cYu6258z9RyEwE4khrgDG7tKj0iysC+5EMKFnac
	nEjkNfrfU1FK1UBQ==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/boot: Remove unused function atou()
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240913005753.1392431-1-linux@treblig.org>
References: <20240913005753.1392431-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173100023098.32228.13434805167417478105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     97ecb260d9c19aa044871ae2c89408c340717b61
Gitweb:        https://git.kernel.org/tip/97ecb260d9c19aa044871ae2c89408c340717b61
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Fri, 13 Sep 2024 01:57:53 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 07 Nov 2024 18:08:23 +01:00

x86/boot: Remove unused function atou()

I can't find any sign of atou() having been used. Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240913005753.1392431-1-linux@treblig.org
---
 arch/x86/boot/boot.h   | 1 -
 arch/x86/boot/string.c | 8 --------
 arch/x86/boot/string.h | 1 -
 3 files changed, 10 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 148ba5c..0f24f7e 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -305,7 +305,6 @@ void initregs(struct biosregs *regs);
 int strcmp(const char *str1, const char *str2);
 int strncmp(const char *cs, const char *ct, size_t count);
 size_t strnlen(const char *s, size_t maxlen);
-unsigned int atou(const char *s);
 unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base);
 size_t strlen(const char *s);
 char *strchr(const char *s, int c);
diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index c23f3b9..84f7a88 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -88,14 +88,6 @@ size_t strnlen(const char *s, size_t maxlen)
 	return (es - s);
 }
 
-unsigned int atou(const char *s)
-{
-	unsigned int i = 0;
-	while (isdigit(*s))
-		i = i * 10 + (*s++ - '0');
-	return i;
-}
-
 /* Works only for digits and letters, but small and fast */
 #define TOLOWER(x) ((x) | 0x20)
 
diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index e5d2c6b..a5b05eb 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -24,7 +24,6 @@ extern size_t strlen(const char *s);
 extern char *strstr(const char *s1, const char *s2);
 extern char *strchr(const char *s, int c);
 extern size_t strnlen(const char *s, size_t maxlen);
-extern unsigned int atou(const char *s);
 extern unsigned long long simple_strtoull(const char *cp, char **endp,
 					  unsigned int base);
 long simple_strtol(const char *cp, char **endp, unsigned int base);

