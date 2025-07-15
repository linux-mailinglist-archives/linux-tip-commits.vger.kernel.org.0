Return-Path: <linux-tip-commits+bounces-6119-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B41B05525
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jul 2025 10:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20787AAAE3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jul 2025 08:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734BF2749D8;
	Tue, 15 Jul 2025 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eG3iz4Jt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FButPfo2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11BC157493;
	Tue, 15 Jul 2025 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568802; cv=none; b=j13Tt4p9Gi3c/lBXDRul7VM7SYEyhmnXlaXeoLYXqQ0Dj3fCdc3AcTiGCOdczBEEnpF2bOsUUhm7Elhk9ayktgEbUKalRsMEByCmkPbhSgBZZe+7x5Q1f/NLnYqTwfmqELrOAyGI2fRCXHWmV0oma3nPW06tiEUHLn77xtifM+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568802; c=relaxed/simple;
	bh=bph2CKLWWA6Zfy6b2rzNQeI7jr7Ng8Jx6WB5b7K4KOU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aK/3fcDuOAgdRd1Yz+Eed8htcUR7DevdpkyU8jLp4o3qdL8njpfcyZ3T8PH/oAAHwjcbQcOQlpuGCOQ2gZ9xTNanUDUUWrsBMAZcYR9F7OkLrUnIRYE+eFyW/7/cEH1ajUJWLoX3pZyZaflUr7psWxnLM4vd520DPI4HVt4Syvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eG3iz4Jt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FButPfo2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Jul 2025 08:39:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752568798;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0RQ+i/p2sJqVF9+ryHw3pXcUBawIFlK4rbiZFvoMyY=;
	b=eG3iz4JtWKfRt3ouMXrLEWLY6Af71JEoUxdSwNzpKAgxoO2KngwyNE7jUOzaYsIMYfQI5G
	pxTA7ZJd0DnmPG0WqSqEEvz0Ly0ECtZkmHkLKxk/YDI6qiKh0gTeFDHqjPS970Mqf/iKEz
	zT97uvPZyH8HgwQDNAAivLCN+4uMi8LrkcMGVENMTCkgdNqm2LliqX7RTuPhvvWzh6wFPS
	/BUDuYrZl8TszeLiEmirTDvONZ5W3br64AC3MjFCB7aM/U+SpTJ1iEa3IL2Izz3UvxAnUS
	rFy9++Df9sHbaPJzTAV0fy9B3+VkVJoKpWaKIn9HuieYb5hsm5ant+x8rwrITg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752568798;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0RQ+i/p2sJqVF9+ryHw3pXcUBawIFlK4rbiZFvoMyY=;
	b=FButPfo2TUEcOuMs6joo1IhEAAf8FzBxzKP2YUZ6knQx9w3LE9z8MST8fEWLexTi1aUyBi
	v1yXsRPe9BZWchAw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Work around broken noinstr on GCC
Cc: Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714073402.4107091-2-ardb+git@google.com>
References: <20250714073402.4107091-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175256879751.406.17891984296859286442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6b995d01683feae619aa3263d18a6aa19bface16
Gitweb:        https://git.kernel.org/tip/6b995d01683feae619aa3263d18a6aa19bface16
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 14 Jul 2025 09:34:03 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 15 Jul 2025 10:12:25 +02:00

x86/sev: Work around broken noinstr on GCC

Forcibly disable KCSAN for the sev-nmi.c source file, which only
contains functions annotated as 'noinstr' but is emitted with calls to
KCSAN instrumentation nonetheless. E.g.,

  vmlinux.o: error: objtool: __sev_es_nmi_complete+0x58: call to __kcsan_check_access() leaves .noinstr.text section
  make[2]: *** [/usr/local/google/home/ardb/linux/scripts/Makefile.vmlinux_o:72: vmlinux.o] Error 1

Fixes: a3cbbb4717e1 ("x86/boot: Move SEV startup code into startup/")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/20250714073402.4107091-2-ardb+git@google.com
---
 arch/x86/coco/sev/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index db3255b..342d79f 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -5,5 +5,6 @@ obj-y += core.o sev-nmi.o vc-handle.o
 # Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
 UBSAN_SANITIZE_sev-nmi.o	:= n
 
-# GCC may fail to respect __no_sanitize_address when inlining
+# GCC may fail to respect __no_sanitize_address or __no_kcsan when inlining
 KASAN_SANITIZE_sev-nmi.o	:= n
+KCSAN_SANITIZE_sev-nmi.o	:= n

