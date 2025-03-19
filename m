Return-Path: <linux-tip-commits+bounces-4321-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7ADA6810A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 01:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0753B85B2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 00:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35E628F5;
	Wed, 19 Mar 2025 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3TTk+gp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF0023A0;
	Wed, 19 Mar 2025 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342673; cv=none; b=bHut0ExcEWjcefskiZkByBrnV6r2edoIgbNZpO+Zrkx9XHYnwOd2S7AgBBMLvGYdwO14xYq8rgnk1CKI1pw1iCC88+aS31k7GmFz9pDU+jGXcEq03zxW9sr36Dn0sNN5FMEG/UKZif0BKUJ0xQo8JzxGqd4IQdhQlbyFu3p7+NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342673; c=relaxed/simple;
	bh=1b6q+8zv9BcRvxVqDkKhOXgzSXTBmV+bshoasyM8gwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sU+0Msw9aHfi2o7rqFB1Opz2z7711MGzw0rXUbszvrhpPPCTKuatd2FwLzDGG0yth/7pG5nbeLHrcQjo9B3z6j+fTjnnZTw0Yb2rGjCjBzWBi20XT/3yW5x4J5VovBDgs9Ny2sWiDVx7p+gouyq8+qFFnABn7x/+2qApX5cXxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3TTk+gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E6CC4CEDD;
	Wed, 19 Mar 2025 00:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742342673;
	bh=1b6q+8zv9BcRvxVqDkKhOXgzSXTBmV+bshoasyM8gwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3TTk+gp1zMzT7kRlDhSmrL28wKR+Dg5dQQx1tx3q019Eedum3AWWsoTPhPrbMPSF
	 sbe80icpjYLztu+7Eh12lqUCWvql0mrFJkWGTTtEY5H9B7jYM6ZQ3KhmZ80GhWJsd1
	 9GAUgcAywChKAz8RlEfo7YO7ex83ABRX1WkpMtewOgo14wD62z7U2CubZC2Ru4XhM/
	 cXp+ArnODA+PKZd4cjOXkxGiasPP5MmXsKkJBosKQRMptVebaI4kLZP88jZSYdMvX7
	 RxWffEPyIJAMepQayCHg+aJGoSGpM1vAjkhgvX6QTtdZ+9BBNEdI9tQd4o+Lys1lIk
	 cBTw80UDZB1pg==
Date: Tue, 18 Mar 2025 17:04:27 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ramon de C Valle <rcvalle@google.com>,
	Matthew Maurer <mmaurer@google.com>, linux-kernel@vger.kernel.org,
	ojeda@kernel.org, linux-tip-commits@vger.kernel.org,
	Scott Constable <scott.d.constable@intel.com>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [tip: x86/core] x86/ibt: Implement FineIBT-BHI mitigation
Message-ID: <20250319000427.GA2617458@ax162>
References: <20250224124200.820402212@infradead.org>
 <174057447519.10177.9447726208823079202.tip-bot2@tip-bot2>
 <20250226195308.GA29387@noisy.programming.kicks-ass.net>
 <CANiq72=3ghFxy8E=AU9p+0imFxKr5iU3sd0hVUXed5BA+KjdNQ@mail.gmail.com>
 <20250310160242.GH19344@noisy.programming.kicks-ass.net>
 <CAOcBZOSPBsTvWFdpwE0-ZU76yMDGBEo3p9y614XYEu+ZSnQ6Sg@mail.gmail.com>
 <CANiq72mcCEbeWb-RAXLcWRnJms2LA6xV=QqQ5=N3ii=3TC89fw@mail.gmail.com>
 <CAOcBZOQnGCqKut-BTvfJNgB9Rz+f5DAANwMs9DU16Js+QDGOrw@mail.gmail.com>
 <20250312091633.GI19424@noisy.programming.kicks-ass.net>
 <CANiq72mi62AkrKzre254DDd_VwUsZzEMqNuXpFeY_4AjObrNVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mi62AkrKzre254DDd_VwUsZzEMqNuXpFeY_4AjObrNVw@mail.gmail.com>

On Wed, Mar 12, 2025 at 12:36:42PM +0100, Miguel Ojeda wrote:
> On Wed, Mar 12, 2025 at 10:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > I normally build llvm toolchains using tc-build, but it seems rust is
> > not actually part of llvm?
> 
> Yeah, Rust uses LLVM but is not part of the LLVM project.
> 
> But I think we could have support to build Rust there easily -- I
> discussed it with Nathan (Cc'd) in the past. Currently, for the
> LLVM+Rust toolchains he provides in kernel.org, he just bundles the
> upstream Rust binaries AFAIR -- and IIRC he uses tc-build to drive
> that build, so if we do that we could also "easily" get the full chain
> in kernel.org too ("easily" if we ignore doing the PGO dance for the
> Rust side etc. and assuming the building time/resources makes it
> doable, which I don't know about).
> 
> If that is correct, I could take a look into adding a simple Rust
> build to tc-build (i.e. without PGO etc.).

Right, tc-build is used to build the toolchain but I have another build
wrapper around that to build the toolchain in a Debian bullseye
userspace for compatibility with glibc 2.28 and newer:

https://github.com/nathanchance/env/tree/c19e35f39080a961a762a6c486ca2b2077ffc4ef/python/pgo-llvm-builder

That is where I had initially considered wiring it up when we last
talked but wiring it up in tc-build would probably be better/cleaner,
especially with the rewrite I did two years ago. I could envision
tc_build/rust.py for example, then either integrating it into
build-llvm.py or have a separate standalone build-rust.py, like
binutils.

Cheers,
Nathan

