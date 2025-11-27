Return-Path: <linux-tip-commits+bounces-7552-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E91C8D608
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Nov 2025 09:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B28A4E6286
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Nov 2025 08:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7F322DD4;
	Thu, 27 Nov 2025 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AUhRi9MF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tnUxc2PZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E7C27FD40;
	Thu, 27 Nov 2025 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764232816; cv=none; b=HOncmeI1uadEFD4VMxIvtBsNRKQYMfO65a6zDTTUzWhZEHaK2KD+VJXzx7ZhZ484c28VFztjnUyeB/aERmEJz5oEvOsJbe9uEMMUOuz0ZDdsA/k7RaiyVXQoN46XnZvFcpXhs+cFSTSZ8LhKmI67vkLciuTzrMbQNgWwp1vNfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764232816; c=relaxed/simple;
	bh=LjrnyN4bTNeaKkgjr8Y0nPlLaLnx+VHXM5fV+bUbIrc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VuiRNtLE+iAVZcVctwZe0DuTFEM24Upnd6AfQEtH0eg0BV7KzR2Q5EbZpCqxEHaXX/4w9OB1bZa8rEEQiR9BejznHY50N2q9nktxujV7L0S7kHu7iQL01a77hzgNrvvR6AsqOecpW9c0a6UGGVeUyIpf15dXw0ShdiqBUsQ/OEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AUhRi9MF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tnUxc2PZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Nov 2025 08:39:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764232805;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5enL7qfxgerUySp8ER2gtzsOYBsUyTal2XL811/9d8=;
	b=AUhRi9MFg6elfrOa5T7TgFBM5oJtK4GlNXUevOqh5R6B6VBiYUSBaqSXhWMLmvxf7WZPXR
	8GEv7qKlO51+0gqrhQS6Zx6F6lpmSfdyaIPYPt4W0OGG2Xy+uRWUDazCi1xzVj1UYUAB4E
	8qzBZdH2thDZR6IuIYIVuMfk00WJZ+NdMwuzdnX8wVIrx2epRqLwcuHVtViRiCl0Nwyis0
	4LLMJathc6R9ihEQMKPjSHNimiXDQ0VyyGKTcS7jc3L4t7lQfsSx8FjwWS4w+rVaTGj2Py
	cbW0kINIYLDeV3pcyjgOwExDD9laR5/5D6ALRygu4+PycGrRsKfbWPA6ss9vuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764232805;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5enL7qfxgerUySp8ER2gtzsOYBsUyTal2XL811/9d8=;
	b=tnUxc2PZQLrwC/tuPsNXbKSmu730ZRtRpXNlkm1qlFRyGEBxK1sSOYgwYw4C+lSJQx9V8r
	wHJ2T5zyUOWL1UBg==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Build with disassembly can fail when
 including bdf.h
Cc: Nathan Chancellor <nathan@kernel.org>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251126134519.1760889-1-alexandre.chartre@oracle.com>
References: <20251126134519.1760889-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176423279957.498.13265832606815539399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     59bfa6408214b6533d8691715cf5459e89b45b89
Gitweb:        https://git.kernel.org/tip/59bfa6408214b6533d8691715cf5459e89b=
45b89
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Wed, 26 Nov 2025 14:45:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Nov 2025 09:32:46 +01:00

objtool: Build with disassembly can fail when including bdf.h

Building objtool with disassembly support can fail when including
the bdf.h file:

  In file included from tools/objtool/include/objtool/arch.h:108,
                   from check.c:14:
  /usr/include/bfd.h:35:2: error: #error config.h must be included before thi=
s header
     35 | #error config.h must be included before this header
        |  ^~~~~

This check is present in the bfd.h file generated from the binutils
source code, but it is not necessarily present in the bfd.h file
provided in a binutil package (for example, it is not present in
the binutil RPM).

The solution to this issue is to define the PACKAGE macro before
including bfd.h. This is the solution suggested by the binutil
developer in bug 14243, and it is used by other kernel tools
which also use bfd.h (perf and bpf).

Fixes: 59953303827ec ("objtool: Disassemble code with libopcodes instead of r=
unning objdump")
Closes: https://lore.kernel.org/all/3fa261fd-3b46-4cbe-b48d-7503aabc96cb@orac=
le.com/
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://sourceware.org/bugzilla/show_bug.cgi?id=3D14243
Link: https://patch.msgid.link/20251126134519.1760889-1-alexandre.chartre@ora=
cle.com
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 66397d7..ad6e1ec 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -87,7 +87,7 @@ BUILD_DISAS :=3D n
=20
 ifeq ($(feature-libbfd),1)
 	BUILD_DISAS :=3D y
-	OBJTOOL_CFLAGS +=3D -DDISAS
+	OBJTOOL_CFLAGS +=3D -DDISAS -DPACKAGE=3D"objtool"
 	OBJTOOL_LDFLAGS +=3D -lopcodes
 endif
=20

