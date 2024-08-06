Return-Path: <linux-tip-commits+bounces-1959-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E31E39497BA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 20:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D271F2333F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 18:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CF036AF8;
	Tue,  6 Aug 2024 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IMRbCaIC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42548F77;
	Tue,  6 Aug 2024 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970128; cv=none; b=N6pJdLnFXa5zCzCopY0BQngsY47eKBCPEPb8qACVIL1rxz65XgkiNTA2yyBHGIAyXMEgBhC77odoH9UkoQNs3Dh4rf4onScwq3uXuiG+N3qy/ntnLaC8EL+vp4gmk+aYAniegF8c3bLU5w6fbejb+SZOaqpt8iOrr6FxJyccdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970128; c=relaxed/simple;
	bh=dmb8MnIsQ45LvpDmstjVoIwppoxS/Sh0KJO+aWBWUco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTxwp+7XbM4y+e2PDvPNaiZjq/yWqZ9Elw0kYpUu9mo4/HG++ESg0BhhWtP9WoW1rW0xirduff6mMBlV0RFMxsC6zsCPqDTgRC2SPtWBQqpXglV+S9fUkqgaAap/faOduoDD6q6NpBtWvV9ZHkxrKTWthfpnzNKdcw6eqUKvw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IMRbCaIC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AeNxfIV7mpbOzFTVofHcft4AOiiZ1fn76DHHxIZMmWY=; b=IMRbCaICZPpKQr7GYNx8yoqKUr
	HnnURJCyJEvHl1S9oQhmlJuIxaskb7rFYnXrO2jHvi2Wsz7+pNt2Ev028hlLJyRLpc2wdl19+bxCq
	leOsRLFy2GEzqnKTtPs6aGTm5kI1j+mvYBXS//6dCl1ZiwsvfnIFu2njDKerLVQ4yVbLjKAZqHsd/
	pCdJz9Ek+6YqmghGvmqX9IvjZHyovJBxobs9JN5do5FQngMv/MPboGn04saBWZkxdS5l8Koe5PQuW
	n/bXb+6GyVDLnYQVTeymSRiQsgEBU0t3E83urn2hJZ/ocVurfi1nt13KJLZUE39TiWTqlrTUD8kip
	5kjnvFSw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbPEi-000000067nY-2eU9;
	Tue, 06 Aug 2024 18:48:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A43DC30066A; Tue,  6 Aug 2024 20:48:43 +0200 (CEST)
Date: Tue, 6 Aug 2024 20:48:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/mm: Fix pti_clone_entry_text() for i386
Message-ID: <20240806184843.GX37996@noisy.programming.kicks-ass.net>
References: <172250973153.2215.13116668336106656424.tip-bot2@tip-bot2>
 <e541b49b-9cc2-47bb-b283-2de70ae3a359@roeck-us.net>
 <20240806085050.GQ37996@noisy.programming.kicks-ass.net>
 <d99175bb-b5ca-46e6-a781-df4d21e9b7a8@roeck-us.net>
 <20240806145632.GR39708@noisy.programming.kicks-ass.net>
 <20240806150515.GS39708@noisy.programming.kicks-ass.net>
 <20240806154653.GT39708@noisy.programming.kicks-ass.net>
 <20240806155922.GH12673@noisy.programming.kicks-ass.net>
 <eab8db58-1eb5-40f7-b7c9-e58558937bf4@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab8db58-1eb5-40f7-b7c9-e58558937bf4@roeck-us.net>

On Tue, Aug 06, 2024 at 09:42:23AM -0700, Guenter Roeck wrote:
> On 8/6/24 08:59, Peter Zijlstra wrote:
> > On Tue, Aug 06, 2024 at 05:46:53PM +0200, Peter Zijlstra wrote:
> > > On Tue, Aug 06, 2024 at 05:05:15PM +0200, Peter Zijlstra wrote:
> > > > On Tue, Aug 06, 2024 at 04:56:32PM +0200, Peter Zijlstra wrote:
> > > > > On Tue, Aug 06, 2024 at 07:25:42AM -0700, Guenter Roeck wrote:
> > > > > 
> > > > > > I created http://server.roeck-us.net/qemu/x86-v6.11-rc2/ with all
> > > > > > the relevant information. Please let me know if you need anything else.
> > > > > 
> > > > > So I grabbed that config, stuck it in the build dir I used last time and
> > > > > upgraded gcc-13 from 13.2 ro 13.3. But alas, my build runs successfully
> > > > > :/
> > > > > 
> > > > > Is there anything else special I missed?
> > > > 
> > > > run.sh is not exacrlty the same this time, different CPU model, that
> > > > made it go.
> > > > 
> > > > OK, lemme poke at this.
> > > 
> > > Urgh, so crypto's late_initcall() does user-mode-helper based modprobe
> > > looking for algorithms before we kick off /bin/init :/
> > > 
> > > This makes things difficult.
> > > 
> > > Urgh.
> > 
> > So the problem is that mark_readonly() splits a code PMD due to NX. Then
> > the second pti_clone_entry_text() finds a kernel PTE but a user PMD
> > mapping for the same address (from the early clone) and gets upset.
> > 
> > And we can't run mark_readonly() sooner, because initcall expect stuff
> > to be RW. But initcalls do modprobe, which runs user crap before we're
> > done initializing everything.
> > 
> > This is a right mess, and I really don't know what to do.
> 
> And there was me thinking this one should be easy to solve. Oh well.
> 
> Maybe Linus has an idea ? I am getting a bit wary to reporting all those
> weird problems to him, though.

While I had dinner with the family, Thomas cooked up the below, which
seems to make it happy.

It basically splits the PMD on the late copy.

---
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index bfdf5f45b137..b6ebbc9c23b1 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -241,7 +241,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
+static pte_t *pti_user_pagetable_walk_pte(unsigned long address, bool late_text)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pmd_t *pmd;
@@ -251,10 +251,15 @@ static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 	if (!pmd)
 		return NULL;
 
-	/* We can't do anything sensible if we hit a large mapping. */
+	/* Large PMD mapping found */
 	if (pmd_leaf(*pmd)) {
-		WARN_ON(1);
-		return NULL;
+		/* Clear the PMD if we hit a large mapping from the first round */
+		if (late_text) {
+			set_pmd(pmd, __pmd(0));
+		} else {
+			WARN_ON_ONCE(1);
+			return NULL;
+		}
 	}
 
 	if (pmd_none(*pmd)) {
@@ -283,7 +288,7 @@ static void __init pti_setup_vsyscall(void)
 	if (!pte || WARN_ON(level != PG_LEVEL_4K) || pte_none(*pte))
 		return;
 
-	target_pte = pti_user_pagetable_walk_pte(VSYSCALL_ADDR);
+	target_pte = pti_user_pagetable_walk_pte(VSYSCALL_ADDR, false);
 	if (WARN_ON(!target_pte))
 		return;
 
@@ -301,7 +306,7 @@ enum pti_clone_level {
 
 static void
 pti_clone_pgtable(unsigned long start, unsigned long end,
-		  enum pti_clone_level level)
+		  enum pti_clone_level level, bool late_text)
 {
 	unsigned long addr;
 
@@ -390,7 +395,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 				return;
 
 			/* Allocate PTE in the user page-table */
-			target_pte = pti_user_pagetable_walk_pte(addr);
+			target_pte = pti_user_pagetable_walk_pte(addr, late_text);
 			if (WARN_ON(!target_pte))
 				return;
 
@@ -452,7 +457,7 @@ static void __init pti_clone_user_shared(void)
 		phys_addr_t pa = per_cpu_ptr_to_phys((void *)va);
 		pte_t *target_pte;
 
-		target_pte = pti_user_pagetable_walk_pte(va);
+		target_pte = pti_user_pagetable_walk_pte(va, false);
 		if (WARN_ON(!target_pte))
 			return;
 
@@ -475,7 +480,7 @@ static void __init pti_clone_user_shared(void)
 	start = CPU_ENTRY_AREA_BASE;
 	end   = start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
 
-	pti_clone_pgtable(start, end, PTI_CLONE_PMD);
+	pti_clone_pgtable(start, end, PTI_CLONE_PMD, false);
 }
 #endif /* CONFIG_X86_64 */
 
@@ -492,11 +497,11 @@ static void __init pti_setup_espfix64(void)
 /*
  * Clone the populated PMDs of the entry text and force it RO.
  */
-static void pti_clone_entry_text(void)
+static void pti_clone_entry_text(bool late)
 {
 	pti_clone_pgtable((unsigned long) __entry_text_start,
 			  (unsigned long) __entry_text_end,
-			  PTI_LEVEL_KERNEL_IMAGE);
+			  PTI_LEVEL_KERNEL_IMAGE, late);
 }
 
 /*
@@ -571,7 +576,7 @@ static void pti_clone_kernel_text(void)
 	 * pti_set_kernel_image_nonglobal() did to clear the
 	 * global bit.
 	 */
-	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE);
+	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE, false);
 
 	/*
 	 * pti_clone_pgtable() will set the global bit in any PMDs
@@ -639,7 +644,7 @@ void __init pti_init(void)
 	/* Undo all global bits from the init pagetables in head_64.S: */
 	pti_set_kernel_image_nonglobal();
 	/* Replace some of the global bits just for shared entry text: */
-	pti_clone_entry_text();
+	pti_clone_entry_text(false);
 	pti_setup_espfix64();
 	pti_setup_vsyscall();
 }
@@ -659,7 +664,7 @@ void pti_finalize(void)
 	 * We need to clone everything (again) that maps parts of the
 	 * kernel image.
 	 */
-	pti_clone_entry_text();
+	pti_clone_entry_text(true);
 	pti_clone_kernel_text();
 
 	debug_checkwx_user();

