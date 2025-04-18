Return-Path: <linux-tip-commits+bounces-5077-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB04A93736
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 14:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0FA1884FB3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 12:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A3D1DF246;
	Fri, 18 Apr 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBB43cfZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C0078F3B;
	Fri, 18 Apr 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979826; cv=none; b=mHG+h+2xdIRrZCrhDCm6Z48j+teiDK84XWNjs8n0TwynhC8G1lwlecrrb/FPunqLp3NUMiC+rc+u9AO5Y3TB2s2S71T+XNBZsoNf1fM59ajpX/enLeMVRT+s8LAMx0U6ITiR4NS7n/H5hxnOndLhsnz/c6OeEu8GDh7RvLWoGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979826; c=relaxed/simple;
	bh=uAwGqPPR0scTOF9o9DPQ6640QiEvf2Of0Y/eQvCW89o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqlfVrO8xbXJC01n5/D+AM4Mlh6wWra7m2NDstineEeDcchQko3o3AoBNl3au/O7DVhtDpOOFm+qr9x2dIJNqsr8iWFylR9Yd+8F7WaUhyOX++vhPBRz8aKfDRrfLOEfmpAXOaoTYzTYoi06p0ZqgyNNQeF5gEfFwZIrqvJhhGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBB43cfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD07C4CEE2;
	Fri, 18 Apr 2025 12:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744979826;
	bh=uAwGqPPR0scTOF9o9DPQ6640QiEvf2Of0Y/eQvCW89o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBB43cfZVHqy/PUx3/sA062W8uEpFmmhpsvwSugJt0+1987X7qo4bb3e/52BncTAB
	 7gSiJHJvvEoKgNQqJQORgyAccLrlEfVai1UVKZOqCRNwigj7gId1y67Nk/SDz6bUlM
	 2g/gkIFXEO7C//dDIEf3fXh+p54oT4OeaIbKLLWpPAQaCODH526aGmb5xqdt6i8DDk
	 5Xsd6A6cwSWCdRU+o6R4fnJKjqmprEqKT6iTSHT27AJRtjaMw6eGcfXR2qtW1kS7Au
	 C2NMNdRH+nkLrsDeWWifGd8IhDw8uRQQKcWq3CBRxKEK4bxpHYb7e3vBP7XXdZ1GOM
	 XgjUmGFuUu8/Q==
Date: Fri, 18 Apr 2025 14:37:02 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>, Rik van Riel <riel@surriel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/alternatives] x86/efi: Make efi_enter/leave_mm() use
 the use_/unuse_temporary_mm() machinery
Message-ID: <aAJHbn4Tp8EA3m7k@gmail.com>
References: <20250402094540.3586683-7-mingo@kernel.org>
 <174448360887.31282.4227052210506129936.tip-bot2@tip-bot2>
 <20250417141751.GAaAENj1RsBOtp2Tvb@fat_crate.local>
 <20250418095034.GR38216@noisy.programming.kicks-ass.net>
 <20250418114350.GAaAI69qRzXARBY5tU@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418114350.GAaAI69qRzXARBY5tU@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Apr 18, 2025 at 11:50:34AM +0200, Peter Zijlstra wrote:
> > Ah yes :-( Something like so perhaps..
> 
> Thanks, that does it.
> 
> Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Applied to tip:x86/alternatives, thanks guys!

	Ingo

