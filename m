Return-Path: <linux-tip-commits+bounces-7826-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 560D9CFA4BD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 06 Jan 2026 19:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7D4E332ECA2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Jan 2026 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F332433D6F7;
	Tue,  6 Jan 2026 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8Vlhu/P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7xHejEEf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80B33D51D;
	Tue,  6 Jan 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719011; cv=none; b=cwoCgWCP3xQBAJEN+AY4WfayYIFQnTTj2xwtrjJnpNSKmAIeB8bbR6kbUYuQWIva2JF8cUxfFOtXJXB43WfG+hkeyhVK/Ku56h706H45iXn7Nlr67elcyFrsg5fh3p26xnK4tRX3Cz5+0WuuOdrxN7KG85gB09Yk+vWu3diehx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719011; c=relaxed/simple;
	bh=bWXPbXmcS3cz+REz5ttcCdu7hnid4DJ2ya5xsyu9ED4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WqtnnSjy/Nixnqf8T2zFsGz6lK2IbHggfKm+llc9hf6fRup19fDh3ymxU08Y54q/1ygJy2Nj5oKhaHjkpdzWisLYfZi2/+6pkxqncDf0LMI4Ed+xMVIH0kk2eGvP3eIW5dmz17Xfr6VzBwDOAExt/K4nZD2HV0TkUUn296/ug88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b8Vlhu/P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7xHejEEf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 Jan 2026 17:03:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767719007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcDBRIQjbWcJPzIpnNLXmO/9HQcng7Yb4bHVdV1aotU=;
	b=b8Vlhu/PlztcD2lBAMYUHOFGaO00bQT/ArocHWWKykZ5O/FINAYZ/Gd4GgHInQrOCkPAVI
	PtGPTc+BYbqZvnyvTsg1q4y8SuyAzh4arVYwImKQr0NiqlEDL5OZlf1WVmw6TogFNCJrls
	lsUUEE8ezwx38K7pgu6DDX/1+GJW6VbxbvAaMBnFfm1MCwmqLYLMGR9hutre4Ma3kBnecl
	jFhtIfngV9+IAT+P69YiYoN+z0yG/FnwTItRrDheeBrVJvScQMcbPcfBKza2o8VuyZ7kAM
	20Z/n2MAnxvmdkN57wxPMpHLqbazfyPfRWVKFrjio33OHT6lfDy9UJN1deLztw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767719007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcDBRIQjbWcJPzIpnNLXmO/9HQcng7Yb4bHVdV1aotU=;
	b=7xHejEEft5Ru4HZqHPBDsYZU8ocZhJp9LpGvHo0wohvi52X7omLv+VEpQ4MJRVl0TsPDFo
	vPaKn5mlobEdtVAA==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Drop unused Kconfig symbol X86_P6_NOP
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260106014708.991447-1-rdunlap@infradead.org>
References: <20260106014708.991447-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176771900565.510.7349356242368179262.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     18fe1f58623f8c1fddd21a3d044d668ba9d8b0a9
Gitweb:        https://git.kernel.org/tip/18fe1f58623f8c1fddd21a3d044d668ba9d=
8b0a9
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Mon, 05 Jan 2026 17:47:08 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 06 Jan 2026 08:57:23 -08:00

x86/cpu: Drop unused Kconfig symbol X86_P6_NOP

This symbol was removed in early 2025 but 2 dangling references to it
were missed. Delete them now.

It should be safe to drop the -mtune=3Dgeneric32 option since gcc 4.3
and later do not cause the problem (see 28f7e66fc1da ("x86: prevent
binutils from being "smart" and generating NOPLs for us")). Also, Arnd
confirmed this with gcc-8 and gcc-15 (see Link:).

Fixes: f388f60ca904 ("x86/cpu: Drop configuration options for early 64-bit CP=
Us")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://patch.msgid.link/20260106014708.991447-1-rdunlap@infradead.org
Link: https://lore.kernel.org/all/c0f0814a-8333-49e1-8e50-740e4c88d94b@app.fa=
stmail.com/
---
 arch/x86/Kconfig.cpufeatures | 2 +-
 arch/x86/Makefile_32.cpu     | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
index 733d5af..b435952 100644
--- a/arch/x86/Kconfig.cpufeatures
+++ b/arch/x86/Kconfig.cpufeatures
@@ -38,7 +38,7 @@ config X86_REQUIRED_FEATURE_ALWAYS
=20
 config X86_REQUIRED_FEATURE_NOPL
 	def_bool y
-	depends on X86_64 || X86_P6_NOP
+	depends on X86_64
=20
 config X86_REQUIRED_FEATURE_CX8
 	def_bool y
diff --git a/arch/x86/Makefile_32.cpu b/arch/x86/Makefile_32.cpu
index af7de9a..a3dda95 100644
--- a/arch/x86/Makefile_32.cpu
+++ b/arch/x86/Makefile_32.cpu
@@ -42,9 +42,3 @@ cflags-$(CONFIG_MGEODE_LX)	+=3D $(call cc-option,-march=3Dg=
eode,-march=3Dpentium-mmx)
 # add at the end to overwrite eventual tuning options from earlier
 # cpu entries
 cflags-$(CONFIG_X86_GENERIC) 	+=3D $(call tune,generic,$(call tune,i686))
-
-# Bug fix for binutils: this option is required in order to keep
-# binutils from generating NOPL instructions against our will.
-ifneq ($(CONFIG_X86_P6_NOP),y)
-cflags-y			+=3D $(call cc-option,-Wa$(comma)-mtune=3Dgeneric32,)
-endif

