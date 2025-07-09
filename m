Return-Path: <linux-tip-commits+bounces-6051-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B60BAFEC7F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 16:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0F51886C04
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E922E54B8;
	Wed,  9 Jul 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KCItp7aJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hC/A5j1c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACDA2D6415;
	Wed,  9 Jul 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072492; cv=none; b=T8v6adZuQPTZW9S/J+0OnWJUj3iZcsHxzbyienLHdbXER/wtG3r2qysKrF3q64OLBb0ZBTh1DVkWrQDd7ahqOACXWaGGJJrDL93quNg8jEpv1UZgYDdvQruR6GXw6sPg2kBZ85Tarak9sFF2qYKVz4Kf7hN1Waeh1FOC0K6fVnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072492; c=relaxed/simple;
	bh=hMJCW8vN0cuWEclz9DWEYnCRh6KKtKx8M4g1/P6vAv0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=cXnxu22whcvkXp/vBFPM1bIE25Lef7Ky4m3dR3Snwje8V3sNXh3jzE+Vkp4e+NBfBsmvkdsIIBbId8YgIP6uKmK1LJILEMMw2iqJeEKbaTomnSJ5SENBJ7B9XdNr0V2DtsKGGB2ELLNGVpqpMgRgyHy6fi808a0gpR8bspT3u74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KCItp7aJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hC/A5j1c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 14:48:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752072488;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XABTU1x5VdUd3N9Nutak7ZDPJ5KYwwgje5Rc8T5bVtM=;
	b=KCItp7aJ4kpwNlU/pWntF67e+UtY2uoZqoS96f1fxYQviU+TFsDC2HrhoJbcnq38YP8NSp
	h+M4YFldpLjuZcNCzAMQatNcWBi/YnmZE/Qgka3O1SsIs8GgikNk5v8lKmOkWska9WqHc4
	DOOfYTzVqnFRYVBZHnkqG/z0DcpK/6N88bjBlsh/9/G1UivfQR9WKCaWp0X6s16EyzJorP
	yrTV5rKBK7asotINdBgZCuz8lZiuqQB4drCD5WqaX1l0WhNzPK/jPaUOUKdf49AYdQi3W4
	AKURPT/yNGCWWpjA9tmzysKglIHHvGmwg8XBluVr3bfxLSdCLItDLpubMN/hNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752072488;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XABTU1x5VdUd3N9Nutak7ZDPJ5KYwwgje5Rc8T5bVtM=;
	b=hC/A5j1c/DX9BCnZj10r/mZUX3vilY7lEsgDMwmycEy5sFtrKssD+rEtddbdpt7NrlSPu3
	SutflbkBL4HeFyBA==
From: "tip-bot2 for Xiaoyao Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] MAINTAINERS: Add KVM mail list to the TDX entry
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175207248719.406.5407381085220800193.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     98de0c686fe4041c57170478d865a482760cc7d9
Gitweb:        https://git.kernel.org/tip/98de0c686fe4041c57170478d865a482760cc7d9
Author:        Xiaoyao Li <xiaoyao.li@intel.com>
AuthorDate:    Wed, 09 Jul 2025 22:10:35 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Jul 2025 07:42:27 -07:00

MAINTAINERS: Add KVM mail list to the TDX entry

KVM is the primary user of TDX within the kernel, and it is KVM that
provides support for running TDX guests.

Add the KVM mailing list to the TDX entry so that KVM people can be
informed of proposed changes and updates related to TDX.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/20250709141035.70299-1-xiaoyao.li%40intel.com
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5893a46..1012ea3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26949,6 +26949,7 @@ R:	Dave Hansen <dave.hansen@linux.intel.com>
 R:	Rick Edgecombe <rick.p.edgecombe@intel.com>
 L:	x86@kernel.org
 L:	linux-coco@lists.linux.dev
+L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
 N:	tdx

