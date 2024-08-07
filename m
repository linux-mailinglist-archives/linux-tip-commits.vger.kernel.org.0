Return-Path: <linux-tip-commits+bounces-1972-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F1394ADFB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C83D1F237EE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214D8136E0E;
	Wed,  7 Aug 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X0rQvXJ1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1mAs6EZ2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5078C90;
	Wed,  7 Aug 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047928; cv=none; b=Cf5NgUr4Ay/KAgCCtUg0/CmCwpsjsIYc0tuzNSjJRIayZqRe5IaRpmcJY1r7B6N2qvd44NrBbzHC+9F3r/rCan4iz59Rh7z1AGUobU/jP1WZRuk8fNxwZ46bB+ZdlKA0f+cd6TsKiwGx/foKLhDpXuvidqYZXaVgt5jq8SHg0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047928; c=relaxed/simple;
	bh=FhPOpRnFdnsOP4EeHy8+qX08Z/WNuEIJywnMuNKn6Kk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MMickmpqXcjWvBI5IunPYpF2ffTCLtQraIxS50JXWJAd1dSHV1VR5C5EZOzWTbZ9lD74fRUzM9VwLXu31lmLgv54GIukjMWEZXk+Ji/y03gucrkT7YeRoxFWwG6t4TQIGob8AHV5EtpD4ROUXOa4H4zX0BKMDwTRB6cFhuoJiIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X0rQvXJ1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1mAs6EZ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3E4erlTa5lMQ6lEE2jQ3MMCoBd0OrWpdNohSUzJu6I=;
	b=X0rQvXJ1qDqlqw41ZYzE+wbwd/hSPWZKB05NJ0uOVCI0zsRQ/PmOG4L8cj3+rTgbMpAT69
	tynwYNjAC5fDcCFaOWU4BK2g/NFh3igQ4dgbOACeUnshL/ubRmc+NzRSMrjHYIZsvaECPX
	8071vQ56pvL/Ctug9XdOW+SQAO8a4Ia1wkD4TcpwHqHHmFupuPi7dM1lZPbjm8Zbm8CXwc
	RTqJEJSdIfS7OAad50F+BLFxWmFYINQqD8eTQC8f1jg8loGnGxq0L20NonAHyz/7FKpvWg
	jvVRJNB1WUK8LeiKq0Q9rJU6JMfpoNxdj3GtorVYk8Y7yAqRq8ZKpL+c1xDzRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3E4erlTa5lMQ6lEE2jQ3MMCoBd0OrWpdNohSUzJu6I=;
	b=1mAs6EZ2DD86fqrqc2UNLcILt1N2gJ1s6UQKz2/QSW0+KSevqHYdLn67yT4zCCgw0dtrIJ
	myzHKoIop78aNqCg==
From: "tip-bot2 for Yue Haibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/apic: Remove unused inline function apic_set_eoi_cb()
Cc: Yue Haibing <yuehaibing@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240803113704.246752-1-yuehaibing@huawei.com>
References: <20240803113704.246752-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792419.2215.2522867076982072332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     00e5bd44389145cd2f42be8e98cadb210731e72a
Gitweb:        https://git.kernel.org/tip/00e5bd44389145cd2f42be8e98cadb210731e72a
Author:        Yue Haibing <yuehaibing@huawei.com>
AuthorDate:    Sat, 03 Aug 2024 19:37:04 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:15:35 +02:00

x86/apic: Remove unused inline function apic_set_eoi_cb()

Commit 2744a7ce34a7 ("x86/apic: Replace acpi_wake_cpu_handler_update() and
apic_set_eoi_cb()") left it unused.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240803113704.246752-1-yuehaibing@huawei.com

---
 arch/x86/include/asm/apic.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 34eaebe..9dd22ee 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -489,7 +489,6 @@ static inline u64 apic_icr_read(void) { return 0; }
 static inline void apic_icr_write(u32 low, u32 high) { }
 static inline void apic_wait_icr_idle(void) { }
 static inline u32 safe_apic_wait_icr_idle(void) { return 0; }
-static inline void apic_set_eoi_cb(void (*eoi)(void)) {}
 static inline void apic_native_eoi(void) { WARN_ON_ONCE(1); }
 static inline void apic_setup_apic_calls(void) { }
 

