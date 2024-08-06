Return-Path: <linux-tip-commits+bounces-1949-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC28948BA6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 10:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891C1B249BD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6951BD006;
	Tue,  6 Aug 2024 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SDcMsWi2"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19BC64A;
	Tue,  6 Aug 2024 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934256; cv=none; b=TjsnAW29sm7sW1A50aCntH7k2DIXxW1sQ2aLWTzD+yJqqBgDc9gLK6UW0plrdvvhwWl9BCqqt1bJ5BDE+Z6rcO86o7hHpj/DUfHlxG40IcFdDwGOlrDfvJ4dhEHOYr5mtfMIB0nr1CVCWHqGDLnong80EUzLYw2+rt1HwAjtXkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934256; c=relaxed/simple;
	bh=I7VarCyBD/Qug+8C+rh9WS75A2zwbL/GTX0llQQ84sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYme+FKvGyf01aQikQyHXt5DoGvsVIMuOyQeWreChdDzqkoftOruPIsffBI2CFsyekekBoy8mi2Ha+15Wj6lammzDXqfD5CO6lAvPbc6lrM/xZspaKaN2R+c7bq0Cdj+YtF0+Os64929Tq9xuKki9eWCZk6RJkWfyl4O9kCVLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SDcMsWi2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oTF9f0l8a28k+RR4zoQZfQZOZh1LqrcguKBYI1uwn5U=; b=SDcMsWi2ttkKpnQF+6TFuSvh2G
	Z0S+TVZKM5HE4Kjy/OHZtDzCNroIG8nekJV3mDBOiQD7V53iq7OXjApGTajmt+PdPbB3xUJo+HGHu
	9lcH2aW7e88xg8fNMBnLisVAFQ0JPdXV3TnB4tttvj7NSaLK/ib1CY5dPP5WrzaElXzlcjhe/QedL
	XxYoMPz8AM8u7M+iXV+trOnbUgfzua/y41NQBimBFVSpGIUn+sq1FWw/WbCBS1yLri/UrwHrbqNpn
	C4xaMYBeKzAZT2iHjvsHFa8dSTYh4bAwyU31Kgb7KWAvzBM2/jCZxgyJmXqXMU5IMFpNy6sdUnYnS
	m4F46kUA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbFu7-00000006OaO-0Tw3;
	Tue, 06 Aug 2024 08:50:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2F1EE30049D; Tue,  6 Aug 2024 10:50:50 +0200 (CEST)
Date: Tue, 6 Aug 2024 10:50:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/mm: Fix pti_clone_entry_text() for i386
Message-ID: <20240806085050.GQ37996@noisy.programming.kicks-ass.net>
References: <172250973153.2215.13116668336106656424.tip-bot2@tip-bot2>
 <e541b49b-9cc2-47bb-b283-2de70ae3a359@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e541b49b-9cc2-47bb-b283-2de70ae3a359@roeck-us.net>

On Mon, Aug 05, 2024 at 09:52:06PM -0700, Guenter Roeck wrote:
> Hi Peter,
> 
> On Thu, Aug 01, 2024 at 10:55:31AM -0000, tip-bot2 for Peter Zijlstra wrote:
> > The following commit has been merged into the x86/urgent branch of tip:
> > 
> > Commit-ID:     49947e7aedfea2573bada0c95b85f6c2363bef9f
> > Gitweb:        https://git.kernel.org/tip/49947e7aedfea2573bada0c95b85f6c2363bef9f
> > Author:        Peter Zijlstra <peterz@infradead.org>
> > AuthorDate:    Thu, 01 Aug 2024 12:42:25 +02:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Thu, 01 Aug 2024 12:48:23 +02:00
> > 
> > x86/mm: Fix pti_clone_entry_text() for i386
> > 
> > While x86_64 has PMD aligned text sections, i386 does not have this
> > luxery. Notably ALIGN_ENTRY_TEXT_END is empty and _etext has PAGE
> > alignment.
> > 
> > This means that text on i386 can be page granular at the tail end,
> > which in turn means that the PTI text clones should consistently
> > account for this.
> > 
> > Make pti_clone_entry_text() consistent with pti_clone_kernel_text().
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> With this patch in the tree, some of my qemu tests (those with PAE enabled)
> report several WARNING backtraces.
> 
> WARNING: CPU: 0 PID: 1 at arch/x86/mm/pti.c:256 pti_clone_pgtable+0x298/0x2dc
> 
> WARNING: CPU: 0 PID: 1 at arch/x86/mm/pti.c:394 pti_clone_pgtable+0x29a/0x2dc
> 
> The backtraces are repeated multiple times.
> 
> Please see
> 
> https://kerneltests.org/builders/qemu-x86-master/builds/253/steps/qemubuildcommand/logs/stdio
> 
> for complete logs.

Could you try the below patch? If that don't work, could you provide the
.config, I'm assuming that'll work with the bits I grabbed last time.


---
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index bfdf5f45b137..bec53f127c0d 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -634,14 +634,8 @@ void __init pti_init(void)
 	}
 #endif
 
-	pti_clone_user_shared();
-
 	/* Undo all global bits from the init pagetables in head_64.S: */
 	pti_set_kernel_image_nonglobal();
-	/* Replace some of the global bits just for shared entry text: */
-	pti_clone_entry_text();
-	pti_setup_espfix64();
-	pti_setup_vsyscall();
 }
 
 /*
@@ -659,7 +653,12 @@ void pti_finalize(void)
 	 * We need to clone everything (again) that maps parts of the
 	 * kernel image.
 	 */
+	pti_clone_user_shared();
+
 	pti_clone_entry_text();
+	pti_setup_espfix64();
+	pti_setup_vsyscall();
+
 	pti_clone_kernel_text();
 
 	debug_checkwx_user();

