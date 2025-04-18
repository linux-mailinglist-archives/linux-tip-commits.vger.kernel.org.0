Return-Path: <linux-tip-commits+bounces-5060-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F86A93454
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 10:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB491B662C2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 08:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E426AAAA;
	Fri, 18 Apr 2025 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlhhEMlU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD819EED3;
	Fri, 18 Apr 2025 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744964086; cv=none; b=i2H8IejtXZsyOKgpiPAeq2UVY/qj2GCiQhi1BUEYdIwmpHCorw4uvo5asowZLTkcFfoS3p8g8hjHGG55ywAtQogKCJv+GC5HO3UZn0qsWtfccwdx2fKEg/xgsXywR8AnoGMP0rLYkmBnhOemYBD3zhMhsoosWXEhGEOnS52Ph/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744964086; c=relaxed/simple;
	bh=XJ02iB/sNPlL8ll61gG2pHZztBaYAqsqo3tsPVveWxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUVbNy2i/zPvSZEjfwd26HshUO6NaW0wwM8XHG5WshfGdu7wGijyWEj+6iAZnt6eTVqPnP0Ibp2V+y4EhimzjUXUP3A0uvgqjv0IoOcaGPj+Cz/s/ospCMeCaFbJHqXHz3Xvm9DNCJj9XFsr+sRWt4t4j/VP3EBatcdUxv9wim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlhhEMlU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6057C4CEE2;
	Fri, 18 Apr 2025 08:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744964084;
	bh=XJ02iB/sNPlL8ll61gG2pHZztBaYAqsqo3tsPVveWxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlhhEMlUiTHC8/PmN5qOJIW33RSW9/04eF9ACjS36P2xd0Q1GXZCJNADK0LLtG1DR
	 VzeAI5vhqwaFoonpb4QmvtBUVaul/trJLChtJ6EIgB6xgwmdDCQeXZ0f2pqmvx7eB1
	 zPSFjmZmPFDz3BGifc2aAO6xa+QunFnoxp6qht6c3F/Ctf3Mxpvk+KW2fwWXZYKnlo
	 JHlnXgoPTB3y08Cp8Pk5I3mJC7zz1hObun0DDcShf8a6VwBmfC13+6C6jCVXzHS0nI
	 +Pk3NSF666DOeuAHocAlAfjOT40inrYcvSaOBM4doPAdrHIsOoxrvGlnY5iKVrieeY
	 fRAj5NKyux3vA==
Date: Fri, 18 Apr 2025 10:14:40 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-efi@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/boot] x86/boot/sev: Avoid shared GHCB page for early
 memory acceptance
Message-ID: <aAIJ8C5Ho97geYMj@gmail.com>
References: <20250410132850.3708703-2-ardb+git@google.com>
 <174448976513.31282.4012948519562214371.tip-bot2@tip-bot2>
 <CAMj1kXFEXZ8cGMwz6N_ToYp0Wf5Vr9UBFRueWx_MtrwbDLq+LQ@mail.gmail.com>
 <Z_rQ4eu4LYh6jGzY@gmail.com>
 <CAMj1kXGTP31w7vM+jWqpbJPmoyPU9vqOrmvXsueoPnBin0y_hQ@mail.gmail.com>
 <aAICRcfkBV3tHP-G@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAICRcfkBV3tHP-G@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Ard Biesheuvel <ardb@kernel.org> wrote:
> 
> > On Sat, 12 Apr 2025 at 22:45, Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > > On Sat, 12 Apr 2025 at 22:29, tip-bot2 for Ard Biesheuvel
> > > > <tip-bot2@linutronix.de> wrote:
> > > > >
> > > > > The following commit has been merged into the x86/boot branch of tip:
> > > > >
> > > >
> > > > This may be slightly premature. I took some of Tom's code, hence the
> > > > co-developed-by, but the should really confirm that what I did is
> > > > correct before we queue this up.
> > >
> > > OK, I've zapped it again, especially as the rest of the series wasn't
> > > ready either, please include the latest version of this patch as part
> > > of the boot/setup/ series, which hard-relies upon it.
> > >
> > 
> > I have sent out a v4 here [0].
> > 
> > I am not including it in the next rev of the startup/ refactor series,
> > given that this change is a fix that also needs to go to stable.
> > Please apply it as a fix and merge back the branch into tip/x86/boot -
> > I will rebase the startup/ refactor series on top of that.
> > 
> > Thanks,
> > 
> > [0] https://lore.kernel.org/linux-efi/20250417202120.1002102-2-ardb+git@google.com/T/#u
> 
> Noted, thanks for the heads up!

So there's this new merge commit in tip:x86/boot:

   54f71aa90c84 Merge branch 'x86/urgent' into x86/boot, to merge dependent commit and fixes

which brings this fix into x86/boot:

   a718833cb456 ("x86/boot/sev: Avoid shared GHCB page for early memory acceptance")

thus 54f71aa90c84 should be a proper base the rest of the startup/ 
series, right?

Thanks,

	Ingo

