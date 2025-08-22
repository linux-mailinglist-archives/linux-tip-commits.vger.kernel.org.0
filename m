Return-Path: <linux-tip-commits+bounces-6313-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4B1B31CD7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71795C07C2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 14:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B533126CC;
	Fri, 22 Aug 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L1hjc4ZO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Du5H1Mf/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B397311C39;
	Fri, 22 Aug 2025 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874189; cv=none; b=CWTZ8hjtivwSTaczEmXxEFrYvyvu4mKy7myOXtGFPXD06D3i4n+UjK5KlCYL43kRYGH2KrMr/dOZq9bKanYUue68AwH4Fn8PDEO4be5r6E1Mh++OMSURZbL+0u/gk2Q+ozH4HvGoCpDIUmBw4vt2O0dU5MM77SzjfpoYu8ElcUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874189; c=relaxed/simple;
	bh=1Q90SWqkcXXikggri8rFuGJOEZdtD53tpU5HToP4Y1s=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=EN/E4UZV6hIR50gnV3RRlR3YaA5pX94TyReBTWGfR4sXO7nkXlOUlOFEo2cuaxYahxsIbdfc4VeZ1PA4DTGxuzCefzZZuTWnsFM7CirQukRW6hMSNX5MEX0vZH1xMJNBKhzg1FV4XKM/gNVUMv+UP1bqIzymrvInwjtCz4/WE9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L1hjc4ZO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Du5H1Mf/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 14:49:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755874184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lYl9kkf6TIv9txDplvC9CpFWzGa+3IfTliG9rEjOfIs=;
	b=L1hjc4ZOYbd+/mms/wP1TZonNpx83oGlv97QGJMg39vtbf4ZrCGvHCr62t2rRZTDdYPmyz
	NYB/flhCb9SJszEMV40h46Ek/d1l0kDvzqzrfALTTj4c/ol3a45rr25IXDog9UAWmYtJOC
	CRX/D74p63GfcV2QWFwA6VlhALiqogvD53izqgC7WgvGqB2H2+L+dxZZfO4eiLVkwHtLhJ
	ID+EFEp9Jy5nHuNc7P0vBUrctBySKI1TZW/QwqFGPnY1AbI/rasGhSUcs57QWs3Dp+I5+X
	rQJULanSUqXGAVvboX29i54zTlsyxa7kdx4eSOqZzCMS5Hb5eEo6pHuJ9QF3+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755874184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lYl9kkf6TIv9txDplvC9CpFWzGa+3IfTliG9rEjOfIs=;
	b=Du5H1Mf/NfZzTydsShtX7JRE6svzjCo7QEZUtuR89a6l6YqNoQTjqEbmRuxw5FjxMI7MHv
	B3L4eBU7fKOMTpCA==
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
Message-ID: <175587418365.1420.4521405387409210086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     d8b483ba4336470805cc04c3a263ddc126c90175
Gitweb:        https://git.kernel.org/tip/d8b483ba4336470805cc04c3a263ddc126c=
90175
Author:        Xiaoyao Li <xiaoyao.li@intel.com>
AuthorDate:    Wed, 09 Jul 2025 22:10:35 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 22 Aug 2025 07:30:23 -07:00

MAINTAINERS: Add KVM mail list to the TDX entry

KVM is the primary user of TDX within the kernel, and it is KVM that
provides support for running TDX guests.

Add the KVM mailing list to the TDX entry so that KVM people can be
informed of proposed changes and updates related to TDX.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/20250709141035.70299-1-xiaoyao.li%40intel.c=
om
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86fae89..707cac7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27328,6 +27328,7 @@ R:	Dave Hansen <dave.hansen@linux.intel.com>
 R:	Rick Edgecombe <rick.p.edgecombe@intel.com>
 L:	x86@kernel.org
 L:	linux-coco@lists.linux.dev
+L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
 N:	tdx

