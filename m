Return-Path: <linux-tip-commits+bounces-4610-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD91A7773C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 11:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9049C7A3A17
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 09:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700141EC009;
	Tue,  1 Apr 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="krMHCop7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1P/8/keG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B11EC011;
	Tue,  1 Apr 2025 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498502; cv=none; b=WJ4o6ei6eNssU763XqZpGhvMgCy6zP7PTHghNZpV34Rhez6xZWyTekoici/lts0/QtFxLsKe5+0N31hQFEoo61eBlp65UQe7RqDZu2XWsaouoxg1qgSzTmHQK1GASOuPQ9oglM2WKGl6f5RV63VUf+fPCXNku/BDaparUtb6mBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498502; c=relaxed/simple;
	bh=0upvQT4yoyliZTAQA6IssiES6vabnF4mIc7Mjn5f8/0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IPxhFhqsy36XP6ih7kT5mwRBvQh3BtdSKeNvjD/rUrHe6PqSREmmareyoFNjZUQJNUSpqMKxoDMREArwB+s1MnCEhm3qUfkP3dzFT8UE6OEvk7UhQFu82nci0CHUyP3MU79Aj1nw2j0B5cwTbNpv8k/NrnltmWDJm5eqi61KbGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=krMHCop7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1P/8/keG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 09:08:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743498498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5E6LoPkxiu2Jk3blFNbujvrPWS6ozc+6s71eXcSeAA=;
	b=krMHCop7PWJWRLVtaW13i+oLTZfP1s1pBZ1xziZ0M25iSvm8gKCSdiyZwuMi6HiOz7NgAi
	jvFMW6YN2/1o23K4nnU0BM5iwxiAg2fCk2MYXBjk+57Htek3U3bXaDv5ZL/afj2/5fRK8z
	oY6d/UEL4I8Hd8oqs8FPuvOpFNxoyQPEHfwgpbX0fwhvuQJL7zVATbpmS1GH0YDtabNZVS
	WsBdmjUHaJLE0hCiu6Rmr+/NGLXp8pAJrLS3H8cabz0LTfCW08k8fXFQXksIoHsUTfJsY9
	IzdGFGRtWAh6m9SKHIlidoGpzMDPbIsgRYOtgws+l6i9o0GojbAznMnbWakoGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743498498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5E6LoPkxiu2Jk3blFNbujvrPWS6ozc+6s71eXcSeAA=;
	b=1P/8/keG2m7VqAGGxC9its2EW1F0ZaPG15gzEpaUh03JAHShOPzh4Dr7c6b0cZxCxN1Xm3
	b4jqPcfh6yHBAwAA==
From: "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/init: Handle the special case of device
 private pages in add_pages(), to not increase max_pfn and trigger
 dma_addressing_limited() bounce buffers
Cc: Bert Karwatzki <spasswolf@web.de>, Balbir Singh <balbirs@nvidia.com>,
 Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250401000752.249348-1-balbirs@nvidia.com>
References: <20250401000752.249348-1-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174349849358.14745.17615225659857776438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7170130e4c72ce0caa0cb42a1627c635cc262821
Gitweb:        https://git.kernel.org/tip/7170130e4c72ce0caa0cb42a1627c635cc2=
62821
Author:        Balbir Singh <balbirs@nvidia.com>
AuthorDate:    Tue, 01 Apr 2025 11:07:52 +11:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 10:52:38 +02:00

x86/mm/init: Handle the special case of device private pages in add_pages(), =
to not increase max_pfn and trigger dma_addressing_limited() bounce buffers

As Bert Karwatzki reported, the following recent commit causes a
performance regression on AMD iGPU and dGPU systems:

  7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")

It exposed a bug with nokaslr and zone device interaction.

The root cause of the bug is that, the GPU driver registers a zone
device private memory region. When KASLR is disabled or the above commit
is applied, the direct_map_physmem_end is set to much higher than 10 TiB
typically to the 64TiB address. When zone device private memory is added
to the system via add_pages(), it bumps up the max_pfn to the same
value. This causes dma_addressing_limited() to return true, since the
device cannot address memory all the way up to max_pfn.

This caused a regression for games played on the iGPU, as it resulted in
the DMA32 zone being used for GPU allocations.

Fix this by not bumping up max_pfn on x86 systems, when pgmap is passed
into add_pages(). The presence of pgmap is used to determine if device
private memory is being added via add_pages().

More details:

devm_request_mem_region() and request_free_mem_region() request for
device private memory. iomem_resource is passed as the base resource
with start and end parameters. iomem_resource's end depends on several
factors, including the platform and virtualization. On x86 for example
on bare metal, this value is set to boot_cpu_data.x86_phys_bits.
boot_cpu_data.x86_phys_bits can change depending on support for MKTME.
By default it is set to the same as log2(direct_map_physmem_end) which
is 46 to 52 bits depending on the number of levels in the page table.
The allocation routines used iomem_resource's end and
direct_map_physmem_end to figure out where to allocate the region.

[ arch/powerpc is also impacted by this problem, but this patch does not fix
  the issue for PowerPC. ]

Testing:

 1. Tested on a virtual machine with test_hmm for zone device inseration

 2. A previous version of this patch was tested by Bert, please see:
    https://lore.kernel.org/lkml/d87680bab997fdc9fb4e638983132af235d9a03a.cam=
el@web.de/

[ mingo: Clarified the comments and the changelog. ]

Reported-by: Bert Karwatzki <spasswolf@web.de>
Tested-by: Bert Karwatzki <spasswolf@web.de>
Fixes: 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
Signed-off-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Link: https://lore.kernel.org/r/20250401000752.249348-1-balbirs@nvidia.com
---
 arch/x86/mm/init_64.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 519aa53..821a0b5 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -959,9 +959,18 @@ int add_pages(int nid, unsigned long start_pfn, unsigned=
 long nr_pages,
 	ret =3D __add_pages(nid, start_pfn, nr_pages, params);
 	WARN_ON_ONCE(ret);
=20
-	/* update max_pfn, max_low_pfn and high_memory */
-	update_end_of_memory_vars(start_pfn << PAGE_SHIFT,
-				  nr_pages << PAGE_SHIFT);
+	/*
+	 * Special case: add_pages() is called by memremap_pages() for adding device
+	 * private pages. Do not bump up max_pfn in the device private path,
+	 * because max_pfn changes affect dma_addressing_limited().
+	 *
+	 * dma_addressing_limited() returning true when max_pfn is the device's
+	 * addressable memory can force device drivers to use bounce buffers
+	 * and impact their performance negatively:
+	 */
+	if (!params->pgmap)
+		/* update max_pfn, max_low_pfn and high_memory */
+		update_end_of_memory_vars(start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
=20
 	return ret;
 }

