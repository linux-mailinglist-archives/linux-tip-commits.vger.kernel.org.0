Return-Path: <linux-tip-commits+bounces-6314-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8782FB31CD2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 16:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BED6188C749
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A843126DF;
	Fri, 22 Aug 2025 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EE331qKX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oaoxcb21"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D704D3126BC;
	Fri, 22 Aug 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874190; cv=none; b=mS9aXMAQVDdVFgx5jUSsDyVudt4Ikfbe3ZSUZfiFbeGOymPghWOy3d+HcjkgWTsToQcPY9TCP6hadJ1LX+UJmYO8sh5VG6Zji6ZXu0FTH9t06W4sSITUmEyfELiIUziE0jvH8K+sPy+wk29Ren5gXLNtBtLSclIsrZOoLOidj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874190; c=relaxed/simple;
	bh=nSriqgmyakWutoc7YMnctwR4DEOKC+GitAVxAsQ4Q/s=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=B4UljiqY30jjIoGV+yi78JAWxmVXFgkfF60xamo4H5sbaPq0tnS+GT9vDK79teKjzR+k9hhWa3oI9FmrfOqfYQObOA2ZRJGMEjsAzTy/ana5DgyP+oGOwbhmMIlIIIVme7mSTODFMlL3etEAho5zBhND2QmkgGutz3KKeksugKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EE331qKX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oaoxcb21; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 14:49:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755874187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GMPM4doGqPqbUV+veRLXLSgCMWPGGnrp7eXqn3PlZc8=;
	b=EE331qKXCnMM/nTsIx+D3V0+e7nX5wEl8XTrSddnU8nvc6YWhqutFl3tI4m/Dv7AEH75EF
	eNMeP5HT4GIygxNlk90Nr5xns6Nm87IFVf6ZnJXMpA7/DPiFpldaAmjWuNjRNwgLOj8sXB
	TiukDGGHMQncPDty/+krrA/A9o7MsOiFydTdm+pNqi2CEtd6rcoPoRN7giIzMY05ncH4ax
	jYf+iho3xe9YIpZFWmLn5WQ1Q/FXYYgiJjLty42oHEUvAkY3WfBqSYOEKeOU1T2WMVQ+dy
	bH8lLzn3JiSReD9CGO2WRaSXpyxJlCDblpSyPDWFZIcLJcjlMsHXqq8RTyvxgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755874187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GMPM4doGqPqbUV+veRLXLSgCMWPGGnrp7eXqn3PlZc8=;
	b=Oaoxcb21KBmCGDD0TLvAKAhZNglolrEy8hF+LEiKhztdXY+7l35xcOIzs+qK4XT15YnRcg
	X2Ti8j/cOCNJchBg==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] MAINTAINERS: Update the file list in the TDX entry.
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175587418597.1420.3376040690345653562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     81e39b6d89b5148480f607f93a88cd16f7df6f4a
Gitweb:        https://git.kernel.org/tip/81e39b6d89b5148480f607f93a88cd16f7d=
f6f4a
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 08 Jul 2025 13:19:20 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 22 Aug 2025 07:30:23 -07:00

MAINTAINERS: Update the file list in the TDX entry.

This includes files that were previously missed in the TDX entry file
list and makes it more future-proof. Most importantly, this now covers
the recently added KVM enabling.

[ dhansen: move from explicit files to "tdx" filename match ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250708101922.50560-2-kirill.shutemov%40li=
nux.intel.com
---
 MAINTAINERS |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a..31632e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27329,13 +27329,8 @@ L:	x86@kernel.org
 L:	linux-coco@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
-F:	Documentation/ABI/testing/sysfs-devices-virtual-misc-tdx_guest
-F:	arch/x86/boot/compressed/tdx*
-F:	arch/x86/coco/tdx/
-F:	arch/x86/include/asm/shared/tdx.h
-F:	arch/x86/include/asm/tdx.h
-F:	arch/x86/virt/vmx/tdx/
-F:	drivers/virt/coco/tdx-guest
+N:	tdx
+K:	\b(tdx)
=20
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>

