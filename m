Return-Path: <linux-tip-commits+bounces-5095-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5B4A9641F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 11:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB2F1885B76
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CBB1F8721;
	Tue, 22 Apr 2025 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZTWSrA4I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ogruQj9w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083B1F5822;
	Tue, 22 Apr 2025 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313760; cv=none; b=nd0yReqaH4ZoKaNg7uoI4/992Pix/q9yDRE8zqzB53RDpv/+Yi2I6O92WD6tXXNr8D6SgedjjiVFnZXUDGL/rcn2wSA7qwUePInJAejQQ1xuWNpjJlnYGZSRuD2le7GEOLfQnVnl2nj5n4owB+ULbZQFa70B91SK4/Ovv+HNSu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313760; c=relaxed/simple;
	bh=uW2rX87F4MRadvrQodcM8YX0KgIV+maUNUJ7Hdg+7Xg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LdZbbq+hZUGQFUymYagbbYlupn62CDrvx451kZGHAJSxNkBRgFWFd2DB2W3KBw0dok1fjdCX7rVvghGLe+Wcf1od1mDPX4LW0RrixRaSRySraPWkzTxRicvNra1NB2o1OmGpf8tBTn6vmoP7ktlLUesAVXFUc2oyfg0P1fJZFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZTWSrA4I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ogruQj9w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Apr 2025 09:22:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745313756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ziWuLAUL75FCKV2/CKbDP2MEFRLaoKzjuTJj35up17g=;
	b=ZTWSrA4I/5HLqNf0J2SkdQZ8itips3u5ohgQ/2FneoswpLoepV+NpWXhlI2+9kfqXsiATq
	mqnvgQvqfIiR5en93ox89RBxoSZ+xvn/UxaCQZz8H90T+A9PHmJxv0AgP+LNIcy+xf3Ckd
	0O+R5UGvXDIWbv5IQ2sPhMbS47quirIHtv52e06re7mwwI8OYvb9EcLWh0SmhD9GqnlApl
	un8t6YoK5mI+Hiui+gYE+iIbOcVVyqioeW6S78H/VmSvIlWcw3fRwMB8tjWJij/3mowOcZ
	72gWOq8uSM/ZokwdIHuUtiJHVb83e+OtfgypJbFqQBSHuhekeC7olAyGqzfa8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745313756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ziWuLAUL75FCKV2/CKbDP2MEFRLaoKzjuTJj35up17g=;
	b=ogruQj9w2r2vVRuGw3G1paUNlHfBPts8tjZ6a+AQofuF5hUpINz0+0oZtSsuL/Mr9wX6yT
	GcsfQppBlh4oJBCg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] vmlinux.lds: Include .data.rel[.local] into .data section
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>, Kevin Loughlin <kevinloughlin@google.com>,
 Len Brown <len.brown@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250418141253.2601348-9-ardb+git@google.com>
References: <20250418141253.2601348-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174531375596.31282.17622952407933210254.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     092071e0f63c2d2c54810a427d4d9a0df6aad52b
Gitweb:        https://git.kernel.org/tip/092071e0f63c2d2c54810a427d4d9a0df6aad52b
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 18 Apr 2025 16:12:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Apr 2025 09:12:00 +02:00

vmlinux.lds: Include .data.rel[.local] into .data section

When running in -fPIC mode, the compiler may decide to emit statically
initialized data objects into .data.rel or .data.rel.local if they
contain absolute references to global or local objects, respectively,
which require fixing up at load time.

This distinction is irrelevant for the kernel, so fold .data.rel and
.data.rel.local into .data.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250418141253.2601348-9-ardb+git@google.com
---
 include/asm-generic/vmlinux.lds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 58a635a..66409bc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -108,13 +108,13 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define TEXT_MAIN .text
 #endif
 #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
-#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
+#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data.rel.* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..L* .bss..compoundliteral*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
-#define DATA_MAIN .data
+#define DATA_MAIN .data .data.rel .data.rel.local
 #define SDATA_MAIN .sdata
 #define RODATA_MAIN .rodata
 #define BSS_MAIN .bss

