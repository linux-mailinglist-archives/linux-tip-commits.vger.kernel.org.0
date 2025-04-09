Return-Path: <linux-tip-commits+bounces-4779-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 969E8A821F4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 12:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69DBD7A6C33
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242A525A32F;
	Wed,  9 Apr 2025 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n7bbcThB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZLbKptei"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B825D537;
	Wed,  9 Apr 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194113; cv=none; b=m9f7t4PyoWjOda2pxoMrK3WSdy5EQ8pfiRULD0XOCD/3EcnOlTrGfRei4fwThZnblOF0ALf02+abfry55Dd+AFg+4yEo3oGO9Bv9K/ABTZGdSS7kO0VXzG2OiwetcF3YsxlWYRh/qrWH7SITsOIpwAjXv2q8Uy1mdTMz3R0T8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194113; c=relaxed/simple;
	bh=j/4jf77R0PebDQIN52aFR5oHc0HxZrYVC7puNNdigD8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AbeLh3tQoUlwGmojv5qMj02kQrrsoF8nb0eDAxNxWTTwYiuXUskvYnq81NNQiz81mazRrBVb7aXv5Cy5TAhzc9FRU795E/Bpws/l4++cRd9cv+j7WdnBFjQ/VeUNzB9eg6F0Gh/+5nysD6nDzIVqNsZdm5l7nq3qkn/3Ioie04M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n7bbcThB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZLbKptei; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 10:21:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744194109;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/LXrH6QOy5Vp7GRM3jyiK+8jqSUek2ehoeMxwLSiz4=;
	b=n7bbcThBhq58IeQM4VQBm0AvUV7uCVB+hAejuFAtYM+73w6Zh+FurufRt7cLsU/ZngMT8V
	vJ3YyMvd9nxsFptg4bbaprYwmaPde5aVItRjRpkq5j/+4qIC80MTmV4Dv0tonuhpm4IlEI
	cuRDAcZOQMc8irNbZh3dcWQsHTbqLVpYTJo+WWvB7NCQ8Yev7rCb/z80b6Pt+ywWVjJ+r+
	zJl1KZ5LtUbpjM7rDqdMp9+RthCkWKWOQnqRylYQNJYVOeVmhmuPnhyFAIL4N0nXAD4S5Q
	ff4WrcZcxKzJ0vxVUOyj7L10GlIaYaVHPjQy8hczhTXQ21fCJ0oBvMz16GvNPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744194109;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/LXrH6QOy5Vp7GRM3jyiK+8jqSUek2ehoeMxwLSiz4=;
	b=ZLbKpteiCw916z/1P7X7uD581C5EFA0vcnl/SfDaULklHv7QGapZUyBX+XLqcG7P7sQ8hM
	RnUHaOUHpta3h7AA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot/startup: Disable objtool validation for library code
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Len Brown <len.brown@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250408085254.836788-10-ardb+git@google.com>
References: <20250408085254.836788-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174419410761.31282.16523291113363404371.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     d9fa398fe82728ee703ad2bd9cf5247df9626470
Gitweb:        https://git.kernel.org/tip/d9fa398fe82728ee703ad2bd9cf5247df9626470
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 08 Apr 2025 10:52:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 11:59:03 +02:00

x86/boot/startup: Disable objtool validation for library code

The library code built under arch/x86/boot/startup is not intended to be
linked into vmlinux but only into the decompressor and/or the EFI stub.

This means objtool validation is not needed here, and may result in
false positive errors for things like missing retpolines.

So disable it for all objects added to lib-y

Tested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250408085254.836788-10-ardb+git@google.com
---
 arch/x86/boot/startup/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 73946a3..8919a1c 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -4,3 +4,9 @@ KBUILD_AFLAGS		+= -D__DISABLE_EXPORTS
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
+
+#
+# Disable objtool validation for all library code, which is intended
+# to be linked into the decompressor or the EFI stub but not vmlinux
+#
+$(patsubst %.o,$(obj)/%.o,$(lib-y)): OBJECT_FILES_NON_STANDARD := y

