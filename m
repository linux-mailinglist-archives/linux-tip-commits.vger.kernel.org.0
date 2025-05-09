Return-Path: <linux-tip-commits+bounces-5515-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A97AB08D4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 May 2025 05:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFFE1B62BF8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 May 2025 03:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A8219319;
	Fri,  9 May 2025 03:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1CywGkS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0192B1F8750;
	Fri,  9 May 2025 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760936; cv=none; b=eixPq34Q8ALsFRk2FyX1HS6H9afNsUXK/hyqb11aT65lOKYpXW39HHbuB7CrBqVpPMfVT0IzEdntyKQ1364A76ZfG50S+DksancojcTPf9a31HogVRF0JQPLaJwYjmnKeKj6eDHAHUyiuueZsQjfhqYXYrxB6z0vznAn7VTBGco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760936; c=relaxed/simple;
	bh=SsNCueF8A7VqlQhoL36fgJMU6tN9VQrjDiQfdzjssck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdrSZ+8Z2HSDSRZ8nEr2tG2mRPt8qI52EkPSka6H5siZbC6tKFP05o0+oC8ACvZNkSOKyfsTn5kB2fI5vT+MmOURvzovwQENydedHbGUecaF1Mj16pPpdavLmv5OO2AAoHgcpNMgbd/9QpOWr5GzOUHKj511wswlatDujxgZUqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1CywGkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50513C4CEE7;
	Fri,  9 May 2025 03:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746760935;
	bh=SsNCueF8A7VqlQhoL36fgJMU6tN9VQrjDiQfdzjssck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m1CywGkSz/rfUQACrb11wBz1Qm4Ni5w42U2CLojgXRQc4fMTZHjojMlXnxJ1qr0A2
	 872U/r5CPd7jVB1++XStw0mDEjfKjLzXaBIdQMmhh35MTKHdNVDLlsCI2PP+VNsNgm
	 GzzzqPf7ICxV4iWVoWGeufzaZCrcDH+omkla1KQGw+4LMkxCZflDggW2qGziYugRwf
	 4hgY71XCAswS3bk0Wnzw5q1z24UpWmWVUFvqTsCmaOuvdmrqmwgWfAE8QPgIcZqbFM
	 ieyMI0NnOn8sUoOsWvjmXKV6Gmm0difqBPDA6XzK8IW3A2jrPQTpNWypYwK6ZkjIH6
	 26YxhtTWuONXw==
Date: Thu, 8 May 2025 20:22:12 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Rong Xu <xur@google.com>
Cc: tip-bot2 for Rong Xu <tip-bot2@linutronix.de>, 
	linux-tip-commits@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [tip: objtool/core] objtool: Fix up st_info in COMDAT group
 section
Message-ID: <cilgdvjaihkdstabhvblpuz3xonuuxtaep462bdipaosbmp4sh@a3tsfzitaibb>
References: <20250425200541.113015-1-xur@google.com>
 <174601619410.22196.10353886760773998736.tip-bot2@tip-bot2>
 <jj4fu243l7ap4bza5imrgjk5f5dhsoloxezgphdjwo7sb5iqsq@wkt46abbt45r>
 <CAF1bQ=SBgs6RiOEXakcZ=TaYjwXngMKNrp8gHL9FhfjOodOxiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF1bQ=SBgs6RiOEXakcZ=TaYjwXngMKNrp8gHL9FhfjOodOxiA@mail.gmail.com>

On Thu, May 08, 2025 at 05:45:18PM -0700, Rong Xu wrote:
> On Wed, May 7, 2025 at 4:22 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Wed, Apr 30, 2025 at 12:29:54PM +0000, tip-bot2 for Rong Xu wrote:
> > > The following commit has been merged into the objtool/core branch of tip:
> > >
> > > Commit-ID:     2cb291596e2c1837238bc322ae3545dacb99d584
> > > Gitweb:        https://git.kernel.org/tip/2cb291596e2c1837238bc322ae3545dacb99d584
> > > Author:        Rong Xu <xur@google.com>
> > > AuthorDate:    Fri, 25 Apr 2025 13:05:41 -07:00
> > > Committer:     Peter Zijlstra <peterz@infradead.org>
> > > CommitterDate: Wed, 30 Apr 2025 13:58:34 +02:00
> > >
> > > objtool: Fix up st_info in COMDAT group section
> > >
> > > When __elf_create_symbol creates a local symbol, it relocates the first
> > > global symbol upwards to make space. Subsequently, elf_update_symbol()
> > > is called to refresh the symbol table section. However, this isn't
> > > sufficient, as other sections might have the reference to the old
> > > symbol index, for instance, the sh_info field of an SHT_GROUP section.
> > >
> > > This patch updates the `sh_info` field when necessary. This field
> > > serves as the key for the COMDAT group. An incorrect key would prevent
> > > the linker's from deduplicating COMDAT symbols, leading to duplicate
> > > definitions in the final link.
> > >
> > > Signed-off-by: Rong Xu <xur@google.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Link: https://lkml.kernel.org/r/20250425200541.113015-1-xur@google.com
> >
> > Unfortunately this patch completely destroys performance when adding a
> > bunch of symbols.  Which I'm doing in v2 of my klp-build patch set.
> The patch won't add symbols. Do you mean the updates take too much time
> when adding symbols?

Right.  I was testing a new feature for generating livepatch modules.  I
was using objtool to add thousands of local symbols to a binary with
-ffunction-sections and -fdata-sections, so it was calling that function
in a tight loop.

> It's probably true as we lookup the sections for every
> added symbols. I did not notice the compile time issues in my builds.

Yeah, I had an extreme test case :-)

> If this is a problem, it needs to be fixed.
> Thanks for working with v2!
> >
> > What was the use case for this?  I don't remember seeing any COMDAT
> > groups in the kernel.
> 
> In the PGO or AutoFDO builds, we used many COMDAT variables for counters
> and control variables. I think the compiler also puts the functions
> defined in header
> as COMDAT.
> The issue I encountered was objtool moved the variables for
> profile_filename and
> profile_version, but the comdat keys were not updated.

I see.  Thanks for the explanation.

-- 
Josh

