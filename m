Return-Path: <linux-tip-commits+bounces-5671-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B56FCABBEC8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 May 2025 15:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E96189F144
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 May 2025 13:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238B627978B;
	Mon, 19 May 2025 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFho0UKb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4461F4717;
	Mon, 19 May 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660357; cv=none; b=q5gMFA1Pq/SQ2hJkDxiO50LEKcjRVmfCNi77MGHuiCl0bWBqRUVNrvrpaLw0KP6Cz+E+UfWhsGeAY7Lv1dN14z3izn2kMxvAdWWi3j7diRpq3LW7VpBsENNsCaAEAkypf5BKbaH5MnBcn0v8MsfWes03J6XdCqGNbhEf5UnDdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660357; c=relaxed/simple;
	bh=w3CKS4X7xF4N+C67MjAVNcLvECf8TZgXw8iZMBtBWZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYx7Xz6lt2E/nCcoNxGsScXtGptm0uxRSiu17QJG9e49S801mJ25ljVrBCZhCHIpgMqLVClAPJd7OwkZ3rdFwP5fpBTs/xcwybc1w8CYzPwgqdSAL1UBkvxaOXamtMnzpgsyuFUu6/Jau84BDoNvb3UqD4yX4GzseUJBvWZSg0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFho0UKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92792C4CEE4;
	Mon, 19 May 2025 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747660356;
	bh=w3CKS4X7xF4N+C67MjAVNcLvECf8TZgXw8iZMBtBWZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFho0UKbVRS9+8eqNBUoUlleNvrXgQJRu05oeKbjUHbzDV3mxmRPcEbIzOvBvwtOy
	 wAo0zmnPa1IKn2LarpK4zoWWBdob/NdRTNQ+5zOy+8VOcogXvhoqP/x4lxrW2FShkk
	 D1htl3hlgJE+onfbBmyrfMhIjUKFmSJXyWZfeHjVAyt8VJog/CFuku2CgKPJls5hYr
	 xYXMWneJo3XWlPp6o9YYSSEzp/o5UJFgQ1Iu/srfPi0TGgrX6qNWUjXGlxMt6xI1tY
	 Pl+cfZJFpB6KZbqHjcDWEzgF9OyXSwcsWOs/bXIupLYNVgLwZBarJRwgfgTHeUl7NT
	 eE7wZvyZlh5Xg==
Date: Mon, 19 May 2025 15:12:31 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/core] x86/cpu: Use a new feature flag for 5-level
 paging
Message-ID: <aCsuP_Au95QjOdWn@gmail.com>
References: <20250517091639.3807875-9-ardb+git@google.com>
 <174765932243.406.15487430117390098144.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174765932243.406.15487430117390098144.tip-bot2@tip-bot2>


* tip-bot2 for Ard Biesheuvel <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/core branch of tip:
> 
> Commit-ID:     ae41ee699c6c89850d11ba64a282490f287d9be7
> Gitweb:        https://git.kernel.org/tip/ae41ee699c6c89850d11ba64a282490f287d9be7
> Author:        Ard Biesheuvel <ardb@kernel.org>
> AuthorDate:    Sat, 17 May 2025 11:16:41 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Mon, 19 May 2025 10:37:21 +02:00
> 
> x86/cpu: Use a new feature flag for 5-level paging

Update: although Linus tentatively acked this series, I've removed this 
commit because it's still under discussion - it appears the synthethic 
CPU flag approach is not universally accepted yet.

Thanks,

	Ingo

