Return-Path: <linux-tip-commits+bounces-4287-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C20A64BC6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 12:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4454188AAB4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577AB1990B7;
	Mon, 17 Mar 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="04Ii0iJr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pNgyY4EB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC178230BC9;
	Mon, 17 Mar 2025 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209648; cv=none; b=qBCzOqJHzNM0vIGF9wS9QSnDCqa9PC0KMO+GeJCM22bxPPOUAyVp9CTNQ/QXm6udeojJlbG5cA2+Ak3DZ9+/hyYexGbq0THYNn8k9FWKsj3zGojKdqWCa4Qiv92rg1Bk2f5P2PXQqQZrxtldyaBsisUdlOz8JscqD2YL7K1mr/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209648; c=relaxed/simple;
	bh=0Xpwo/Y0UX8dYJiqPFctM7BIYCy3TALEamqou9qX/VY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d1htu4O8rw+dKxxqG5IwqVbKXNa8R9ARWLu7LtamkjZNW19eriadhjR/nZqF5jXesPL7Vl1lZx+UMbKsHcxY2KpF1WEmumKqi1NeLkBx6Pvne71yioFFBAwfCaObJjgzZesIw1EZ93+0Ae4try7uDuhHzJfE6QChzcSEhea9ZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=04Ii0iJr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pNgyY4EB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 11:07:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742209644;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cM/W7c+04DZc8h/mlBf+C09lLMYiLYoX4ALWFs9yKms=;
	b=04Ii0iJrLdvXH+Zlys8VxoCOC3/fxbUvkux0IOnbhs2AUgZsQRZlJqS+steZ2lzqzKhk18
	TCASGtUpLWA0WdNvMYRl/9tP7u+EbjwrxIF0QRZfspHMAcs7PFMjcUfBkgnKvxqFlTTlhy
	i5pOJHbihkYQQm5P54jZCHzkF0sXAXg8h2ls6ZAAE2xKzk9ZCHbf0PuDpOoka/QFKU1YLm
	CXFXrGtnQdNsUXQvXrjemZ2qjh7PcZDSyoUrifYqLNBihLzCE33ka7R5krViP53JonrJf9
	vC4pbcyphOIV6D5BMdFSGzuiia5CSu39PpunyaembjC/fKQuOAQDbvBj7jIifA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742209644;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cM/W7c+04DZc8h/mlBf+C09lLMYiLYoX4ALWFs9yKms=;
	b=pNgyY4EB/NhT4VeTXqA/19aV04i8ydcTh3IbPxrtSQQH9WMyEYLguPakMwu+NS/S3jvXYS
	5luM0pFnxjkKhKBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add CONFIG_OBJTOOL_WERROR
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
References:
 <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220964327.14745.17925905226268456380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     36799069b48198e5ce92d99310060c4aecb4b3e3
Gitweb:        https://git.kernel.org/tip/36799069b48198e5ce92d99310060c4aecb4b3e3
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 14 Mar 2025 12:29:11 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:51:44 +01:00

objtool: Add CONFIG_OBJTOOL_WERROR

Objtool warnings can be indicative of crashes, broken live patching, or
even boot failures.  Ignoring them is not recommended.

Add CONFIG_OBJTOOL_WERROR to upgrade objtool warnings to errors by
enabling the objtool --Werror option.  Also set --backtrace to print the
branches leading up to the warning, which can help considerably when
debugging certain warnings.

To avoid breaking bots too badly for now, make it the default for real
world builds only (!COMPILE_TEST).

Co-developed-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org
---
 lib/Kconfig.debug    | 11 +++++++++++
 scripts/Makefile.lib |  1 +
 2 files changed, 12 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 35796c2..a9709a6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -545,6 +545,17 @@ config FRAME_POINTER
 config OBJTOOL
 	bool
 
+config OBJTOOL_WERROR
+	bool "Upgrade objtool warnings to errors"
+	depends on OBJTOOL && !COMPILE_TEST
+	help
+	  Fail the build on objtool warnings.
+
+	  Objtool warnings can indicate kernel instability, including boot
+	  failures.  This option is highly recommended.
+
+	  If unsure, say Y.
+
 config STACK_VALIDATION
 	bool "Compile-time stack metadata validation"
 	depends on HAVE_STACK_VALIDATION && UNWINDER_FRAME_POINTER
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index cad20f0..99e2819 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -277,6 +277,7 @@ objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
 objtool-args-$(CONFIG_GCOV_KERNEL)			+= --no-unreachable
 objtool-args-$(CONFIG_PREFIX_SYMBOLS)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
+objtool-args-$(CONFIG_OBJTOOL_WERROR)			+= --Werror --backtrace
 
 objtool-args = $(objtool-args-y)					\
 	$(if $(delay-objtool), --link)					\

