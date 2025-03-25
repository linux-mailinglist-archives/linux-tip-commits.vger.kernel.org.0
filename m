Return-Path: <linux-tip-commits+bounces-4530-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA58A6F455
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 12:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938451883042
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 11:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F896255E3D;
	Tue, 25 Mar 2025 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhUORY6i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F019F111;
	Tue, 25 Mar 2025 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902579; cv=none; b=TuG0fuPCj5oRntasbVbIRgIGqZXjikaQ1muL9GfHWohZlkyKHQ8TnOQTP/3FdJght4t+7w9bYmoOlkU4yoJwe0N4vBMlByTNCcyHri/LK9dJ2I51/3/HjuxM7XW/GkAEcxGUvhNKugwKh7XP4uYxOuveoOnQFY9CAslAd6ie24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902579; c=relaxed/simple;
	bh=rIbXhljOkxj2z3hzqg0CcvUqSKlVyl2BPT33QXRtPXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhfc5w77nJ7oBb4Az3UJPQWxTwH60be/SjfE8PH6Fj/Z2ceMb4QpsoTRjzY4zoncQQXhwVfWOILWL968t4K0y3DfKsFlpGEEw1pJfDNx2cUUoyW1TXygDCGuo+8SYIU5BhqypOvYp2zpcZJQBWvJdvJ9uiaDYYLycUgxwPd3Fcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhUORY6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C64C4CEE4;
	Tue, 25 Mar 2025 11:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902576;
	bh=rIbXhljOkxj2z3hzqg0CcvUqSKlVyl2BPT33QXRtPXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhUORY6iPrt3Im7+lu/cmCHKOKSvub7lONUBIxo1zpt7KoPO0nQ5Wra75x6o98Y7V
	 b0gNIvhMOBPplGuYSJdm+NjjOsK+orDAVReSk38g+BPecK2nU+4J9TdDA6JLPVxAaw
	 e6pQzuDAbUyJE4Kikm+aCiazcrX0u0yNUu5/7DAriagPPFp5ye0Lfff4jSXNni17gK
	 n66Vi2+LE6oCkAf4+GgpKGu2e/lR0KtNaPbz83/oG0EvicsP6xbCgiY42gem0SjHTP
	 8Zxen0kRRVU1FyLU6f2epF0+f/22ANHKR6bLkKL/744aiCe1Qz+/EA2w9E8Ww/RQH1
	 gfxAhoB2BA9Ng==
Date: Tue, 25 Mar 2025 12:36:11 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, ASoC: codecs: wcd934x: Remove
 potential undefined behavior in wcd934x_slim_irq_handler()
Message-ID: <Z-KVKztS2TXoafRC@gmail.com>
References: <7e863839ec7301bf9c0f429a03873d44e484c31c.1742852847.git.jpoimboe@kernel.org>
 <174289169388.14745.12400458342392826127.tip-bot2@tip-bot2>
 <0b3b6878-a1c1-4cd0-b2a8-d70833759578@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b3b6878-a1c1-4cd0-b2a8-d70833759578@sirena.org.uk>


* Mark Brown <broonie@kernel.org> wrote:

> On Tue, Mar 25, 2025 at 08:34:53AM -0000, tip-bot2 for Josh Poimboeuf wrote:
> > The following commit has been merged into the objtool/urgent branch of tip:
> > 
> > Commit-ID:     46b70c569b774ea2c671bb3aff2a50d29760b7c3
> > Gitweb:        https://git.kernel.org/tip/46b70c569b774ea2c671bb3aff2a50d29760b7c3
> > Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> > AuthorDate:    Mon, 24 Mar 2025 14:56:09 -07:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Tue, 25 Mar 2025 09:20:29 +01:00
> > 
> > objtool, ASoC: codecs: wcd934x: Remove potential undefined behavior in wcd934x_slim_irq_handler()
> 
> FWIW the original patch doesn't seem to have made it into my inbox 
> (the regmap one did), not that it makes a *huge* difference but might 
> be some infra/script issue which crops up on some other more urgent 
> occasion.

Yeah, I noticed that the Cc: lines were incomplete for some of the 
patches, so before applying them I went over the series and regenerated 
the Cc: lines so everyone is informed and can review/object/ack if 
necessary.

If there's any serious mistake we'll rebase the branch!

Thanks,

	Ingo

