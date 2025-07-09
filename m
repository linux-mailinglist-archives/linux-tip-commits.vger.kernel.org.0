Return-Path: <linux-tip-commits+bounces-6054-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99A2AFEC86
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 16:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5006A643755
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69682E7167;
	Wed,  9 Jul 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QhDWhKcE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YeW+rprh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78E2E5B20;
	Wed,  9 Jul 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072494; cv=none; b=SOs3x/CsohcPVdyoZofuwqyntKtUy+3LILdRFzWBuFMvLg43s8zxVsOcyA8X8g9E4sRALJ95nJes9zLp1RrnNMYXk9hJyS2KcmjdLzc+/LcUcVVRYLX9ss4TmU9eFXNsQY2L6CRu4fQWN2V2X64FEXBeqAgAld/NNSVGuBia8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072494; c=relaxed/simple;
	bh=C14hDQn7BXEKeMeRQt9gSz9FQ5n0pyJdSeEkMOE9gDQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Hddl3yV/zuLpGUAMwv5TW6aln4TvUo7BRINOl9MkNnQWiA3XA/pj1U3BV/AGi6JBeH+U5iaxz0RCB1VsDeAHYCMktMXUIT+0XYh1bvTXnxaW7fEmWqrohBrsLWqpojGU/fuUID7ZBmwIf+5sEgKPCOqd/skZvNkLznmKtErxv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QhDWhKcE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YeW+rprh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 14:48:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752072491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cPY20RPxrT9Y2Z2lRNbKmuBwSaPMCuWPMDPbqgl3KQg=;
	b=QhDWhKcEJ+EWPnp233Dfwbj0Zbt/KBLn2EdvaMBb0owV7G7i/3YBCcpTUS344xMmQssUUH
	dO0CXGlRXfzpzayV3Fv54kw+tmdBLJBwKGhsp9vnnR3r2jK4xahcIpMlg92WgbisK0LZnc
	vr9ItR/xV6bwRyUVCtsbUxcjuuwb+n+jKMapWTDeGhKQtpUFo+eFWxqm5PEE4OnUjepoGk
	ukmjbUUIHnVupHFDkisJWeap9HbaVMxSfEPLDOhztGG7D8p6G++fW0Z7jFR69is8imSXVk
	fQbDGcjXrjM/6KSUEaKXDDK+Q/maPBHdIajIL8QRC3p6Y/qdLKGdTsTXRI8XsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752072491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cPY20RPxrT9Y2Z2lRNbKmuBwSaPMCuWPMDPbqgl3KQg=;
	b=YeW+rprh1NySJf0f0iYdVaV2hWJmmvWZoPBor6y/9K2jmrYLjeIPvWTDxfBFz0y83MLQPl
	fI9tI2Gzn0HWlECA==
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
Message-ID: <175207249023.406.17832281867647565973.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     c2eed180555bc404917afc41637154d5aa2527c2
Gitweb:        https://git.kernel.org/tip/c2eed180555bc404917afc41637154d5aa2527c2
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 08 Jul 2025 13:19:20 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Jul 2025 07:38:14 -07:00

MAINTAINERS: Update the file list in the TDX entry.

This includes files that were previously missed in the TDX entry file
list and makes it more future-proof. Most importantly, this now covers
the recently added KVM enabling.

[ dhansen: move from explicit files to "tdx" filename match ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250708101922.50560-2-kirill.shutemov%40linux.intel.com
---
 MAINTAINERS |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fad6cb0..f41f627 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26950,13 +26950,8 @@ L:	x86@kernel.org
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
 
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>

