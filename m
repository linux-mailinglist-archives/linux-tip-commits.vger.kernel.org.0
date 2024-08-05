Return-Path: <linux-tip-commits+bounces-1943-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1E8947CA0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 16:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E70B21A19
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4757D13A24A;
	Mon,  5 Aug 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gc7vNs+Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0xFIM+wb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434F12EBCA;
	Mon,  5 Aug 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867234; cv=none; b=McO687JPPgK8u0EN+jgoNXQM//egW15o7SyWVLQIvmPaW4gukwda6FUrIv35IQh3E4N6pYCt0VUoUyVumSOcVtH3GRx6hSi5sKYCXm2GJFZkNgRJHSYaJHUUx0bXLseZIaIJmwbDXCpcrC30m/+ycci3FqevSa3gLNsZkCFqAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867234; c=relaxed/simple;
	bh=aoA+4Es0w7B+mB/wEEX5x1oEgFQOrty8kg2uAcCVqjw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iuGSdB6enOX+WWcbNVMuUAt+FvaEVLfXqxC/q3LvafpqrJon+nL33wKgg4B5zf9/26XkTUrSmUjqAj14TbbGgb5cSTd05ZRvMQkiNJ8WaUojyH/nQxnRYM97YlOu+8bwys3hlDjow8oSvAQoQfLGw23UGPBEp5AdMpmYHYde710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gc7vNs+Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0xFIM+wb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 14:13:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722867230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unVmUiTk7/pBC9oIkFGPQpSzmYPX/OfnxCi75WHip1M=;
	b=Gc7vNs+YqNQpMAWEikToHbFm5L666kz8Q3e66/VvtSuv31FwNsCaLuVL54s2ErigRZfvpF
	PUxyPmU88QjaRJq9JOn5gv9h+zbUrMiq8EN3d4DpJ12Tt8c/6m1QRgVzdNCuSSa/sHIDTg
	YXHe9kfWUrTUAtK17yYkk8LwOT3lBlyrKcBVLj+K+Y5mxAcIiZvbBeB9tQbPlyGlRp8Nzr
	ACUDGJxO0eU/VANCwUow+0+SZQ/MF5igJTwscH1s8IHXcRdq0qcNjXZpv5nqQKHKdk33H9
	K6KoDDL3Elaz3QuVWOUy2UQGF+52b9iGrhtcd91JnURCECxGbHq7/oUr5Og3yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722867230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unVmUiTk7/pBC9oIkFGPQpSzmYPX/OfnxCi75WHip1M=;
	b=0xFIM+wbv44VT3GX9GsIXL2GhUIoRvNwi1U2t56R/69NelEDgtq0Sw7kxhMMcIbaw4iSV3
	syulcINpI8OvLeDA==
From: "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/ident_map: Use gbpages only where full GB page
 should be mapped.
Cc: Steve Wahl <steve.wahl@hpe.com>, Thomas Gleixner <tglx@linutronix.de>,
 Pavin Joseph <me@pavinjoseph.com>, Sarah Brofeldt <srhb@dbc.dk>,
 Eric Hagberg <ehagberg@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240717213121.3064030-3-steve.wahl@hpe.com>
References: <20240717213121.3064030-3-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172286723019.2215.3511705011179177500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     cc31744a294584a36bf764a0ffa3255a8e69f036
Gitweb:        https://git.kernel.org/tip/cc31744a294584a36bf764a0ffa3255a8e69f036
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Wed, 17 Jul 2024 16:31:21 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Aug 2024 16:09:31 +02:00

x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

When ident_pud_init() uses only GB pages to create identity maps, large
ranges of addresses not actually requested can be included in the resulting
table; a 4K request will map a full GB.  This can include a lot of extra
address space past that requested, including areas marked reserved by the
BIOS.  That allows processor speculation into reserved regions, that on UV
systems can cause system halts.

Only use GB pages when map creation requests include the full GB page of
space.  Fall back to using smaller 2M pages when only portions of a GB page
are included in the request.

No attempt is made to coalesce mapping requests. If a request requires a
map entry at the 2M (pmd) level, subsequent mapping requests within the
same 1G region will also be at the pmd level, even if adjacent or
overlapping such requests could have been combined to map a full GB page.
Existing usage starts with larger regions and then adds smaller regions, so
this should not have any great consequence.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavin Joseph <me@pavinjoseph.com>
Tested-by: Sarah Brofeldt <srhb@dbc.dk>
Tested-by: Eric Hagberg <ehagberg@gmail.com>
Link: https://lore.kernel.org/all/20240717213121.3064030-3-steve.wahl@hpe.com

---
 arch/x86/mm/ident_map.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index c451272..437e96f 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -99,18 +99,31 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
+		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		if (info->direct_gbpages) {
-			pud_t pudval;
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_leaf(*pud))
+			continue;
+
+		/* Is using a gbpage allowed? */
+		use_gbpage = info->direct_gbpages;
 
-			if (pud_present(*pud))
-				continue;
+		/* Don't use gbpage if it maps more than the requested region. */
+		/* at the begining: */
+		use_gbpage &= ((addr & ~PUD_MASK) == 0);
+		/* ... or at the end: */
+		use_gbpage &= ((next & ~PUD_MASK) == 0);
+
+		/* Never overwrite existing mappings */
+		use_gbpage &= !pud_present(*pud);
+
+		if (use_gbpage) {
+			pud_t pudval;
 
-			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;

