Return-Path: <linux-tip-commits+bounces-7588-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D156CA0B62
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 18:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 996373006FF9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 17:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A9330308;
	Wed,  3 Dec 2025 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8vDPJIm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D3032FA34;
	Wed,  3 Dec 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784305; cv=none; b=P+beydeMXwzs0TNzltY42AvunplX154NT1srP2+CIsaElWFSJuulPdASG+3M8noIgXC9MGFXQYFjNhw5QKIbXEW8nOekCyc4nW5DdYfRUomP68lPI0gUAPYGEPMxmxDSODauQB2SZgx4WchknwwcyMXUgfLAVV0vasY250vt4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784305; c=relaxed/simple;
	bh=zwppoAcl+2dMzdo/qWyK1NJadnRlguaRQAk7OcjHRho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPZXKiC8sT//UyyWQRl81vcGGAgHMvehh8FLszXoQaIKOPbxpyDXoXtXylAz3CiW24OCCL3rYxhmcKNejjqnwVfaybTbmFyiuZQeKCvp6QDqA7p3xflUF9ZdY2XZDgdrzDvkW2p9R6lBLStPAWiR8Xrtrmd9x92wt0+Ke0Xv1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8vDPJIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CAFC116C6;
	Wed,  3 Dec 2025 17:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764784304;
	bh=zwppoAcl+2dMzdo/qWyK1NJadnRlguaRQAk7OcjHRho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8vDPJImWT1AEpf0RxHJxWYAW2S32ULVy1waUfVMAxaj7F6PvLmvxck+onw8lYGYl
	 iUqefKzbWPCTyTK5UCRfVdVfAh8QkwMr38pIBKNHAylA/vXw616GbUY1V7v4B+gy2g
	 ffaTsyLxbMXmPUyCNi3z509DKgrEPmpUZSwDlhRMHW+uHhLiNVwzhvzWTNi0VTCh+B
	 oYZ4J5JhNf7CTx952OF+hsrxe4c9dsdrJM7Wd0gfxcGv9erfcFRambkhNecvA4eBA+
	 ztKx3VIMleVEmONbuZOWuA9KIkch5vhwK1UEjHftYv2RAeLj/QJDd9bnPzCCI+MAth
	 F3DrTPedTeAeA==
Date: Wed, 3 Dec 2025 09:51:42 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool: Consolidate annotation macros
Message-ID: <bp6dxqsfa66txee3b7kzqgj2hgzow6ukvffczn2fz43kn53prv@2zlw65irjsc6>
References: <c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.1764694625.git.jpoimboe@kernel.org>
 <176478003405.498.13298696533128884255.tip-bot2@tip-bot2>
 <CAHk-=wgzL-bCggZOuDU7_f-1jpjus8Oaqtek9T8GdGUexnHYkg@mail.gmail.com>
 <aTBr3ImmrJQe4G49@gmail.com>
 <CAHk-=wjc4BeSu7dHB=5AuQNWQ=sOGAuH4j0=uRwsGyiSo+m+bw@mail.gmail.com>
 <CAHk-=wgTWezdprq6eBYAv52r6JYoD_oBjouUfsbvMZqtpYjWfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgTWezdprq6eBYAv52r6JYoD_oBjouUfsbvMZqtpYjWfQ@mail.gmail.com>

On Wed, Dec 03, 2025 at 09:44:45AM -0800, Linus Torvalds wrote:
> On Wed, 3 Dec 2025 at 09:21, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It *feels* like this should just all be
> >
> >         911: .pushsection .discard.annotate_insn ; .long 911b - .; .long 1; .popsection
> >         jmp __x86_return_thunk
> >
> > instead.
> 
> Actually, I think it should just be
> 
>   911: jmp __x86_return_thunk
>   .pushsection .discard.annotate_insn ; .long 911b - . , 1; .popsection
> 
> but again: it's entirely possible that there's something I am missing.

Indeed, we can combine the longs (though see my other email for the
explanation about the mergeable thing).

-- 
Josh

