Return-Path: <linux-tip-commits+bounces-3561-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B24BA3F5B9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 14:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC9C19C74D8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 13:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C987150980;
	Fri, 21 Feb 2025 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B0tz05hs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C9sXG3fA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89C1DFF7;
	Fri, 21 Feb 2025 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143814; cv=none; b=oZnm3MuSNxBwmucDIfNP0JkADqdC6omKP60hSeknTRW4fqSf9Gh9uA0Pp+MelwFFC6lLTsiHJeQouC/Mv0OJlKxpQ4vXknwl6VqA0vGeJnUXRbxryp5ngvu86jOnF3EnmcYKw6qYEvZ5dngI0K+9VeCpCCB5DL8C5pDjAyuGeoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143814; c=relaxed/simple;
	bh=s6izq4i+E02HhRjQkccsm0geW0vOCOEdFReFIdgUn0E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JF28vOjdEIB9IXlycWmAcuBUxnFF/GsNdUeG1m3lFfcbA8ieErBwVv4CtFIaG7fqkstVKgfAUGUnwM5tLV8e08tYIyrOezTOwilNtVmOCagfrrQ8xjYtQVgqhPWOJNpojuR8Ja9BWuLFIYjRWQukrCZRLf/EOs5nMZ04silOLNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B0tz05hs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C9sXG3fA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 13:16:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740143810;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSNUpnZS9Opw3aYHbfY1rn2ZAFjK0egvr5v04TaCI6Y=;
	b=B0tz05hsxA5sjQTaBdYjkJYMaWz2Jg6ehz6lZ70a65hfNmgqUQbP+8crNjpXo1HpwGYt9q
	JBQzawUFPAlLKUqW2sZWP0A5VRwvLnbj4BKiqaIpzWze1ny/XluwJJTjaUiq8OFcKlOWmw
	noM8PQYfnY+eS8t361VeTfxytCO9IURRVq2xBu5m+mRquKcOSmC6RplWFMhf7xMEMeuZfN
	dwaYG385QQ95BL7+VCVxJCTiS5XLu9Z8Cyyo3hv2qutpXpQYP7FIg/4BciFEDJou5tfy8d
	5VgN9J0ZWzxPE5DHtbbfRPlB3vv9KYR7TJvEEnImD1Ku1grNeu19vXPjmYFcDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740143810;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSNUpnZS9Opw3aYHbfY1rn2ZAFjK0egvr5v04TaCI6Y=;
	b=C9sXG3fADXZpSt/OJYysI5eR3LG1LX9uhF9lLsmbShCbajWVOSNxdmeA0si7cz1TPt/c9Q
	i98Uae1oAKfof5CA==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/build: Raise the minimum LLVM version to 15.0.0
Cc: Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250220-x86-bump-min-llvm-for-stackp-v1-1-ecb3c906e790@kernel.org>
References:
 <20250220-x86-bump-min-llvm-for-stackp-v1-1-ecb3c906e790@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174014380628.10177.1455453395562694018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     7861640aac52bbbb3dc2cd40fb93dfb3b3d0f43c
Gitweb:        https://git.kernel.org/tip/7861640aac52bbbb3dc2cd40fb93dfb3b3d0f43c
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Thu, 20 Feb 2025 13:08:12 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 14:08:16 +01:00

x86/build: Raise the minimum LLVM version to 15.0.0

In a similar vein as to this pending commit in the x86/asm tree:

  a3e8fe814ad1 ("x86/build: Raise the minimum GCC version to 8.1")

... bump the minimum supported version of LLVM for building x86 kernels
to 15.0.0, as that is the first version that has support for
'-mstack-protector-guard-symbol', which is used unconditionally after:

  80d47defddc0 ("x86/stackprotector/64: Convert to normal per-CPU variable"):

Older Clang versions will fail the build with:

  clang-14: error: unknown argument: '-mstack-protector-guard-symbol=__ref_stack_chk_guard'

Fixes: 80d47defddc0 ("x86/stackprotector/64: Convert to normal per-CPU variable")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Brian Gerst <brgerst@gmail.com>
Link: https://lore.kernel.org/r/20250220-x86-bump-min-llvm-for-stackp-v1-1-ecb3c906e790@kernel.org
---
 scripts/min-tool-version.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 06c4e41..7878681 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -26,7 +26,7 @@ gcc)
 	fi
 	;;
 llvm)
-	if [ "$SRCARCH" = s390 ]; then
+	if [ "$SRCARCH" = s390 -o "$SRCARCH" = x86 ]; then
 		echo 15.0.0
 	elif [ "$SRCARCH" = loongarch ]; then
 		echo 18.0.0

