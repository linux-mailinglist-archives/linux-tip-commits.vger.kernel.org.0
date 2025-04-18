Return-Path: <linux-tip-commits+bounces-5074-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA766A936A2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 13:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1840417EE75
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805E1D5170;
	Fri, 18 Apr 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZUcsCc+J"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433481885A5;
	Fri, 18 Apr 2025 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744976655; cv=none; b=RzVA7y3i7YBsT4jpNblQGwRT2kjT8SsDYEeEWdudgBV1yh8xbszLc5zpuzojPS7gfx52d5QP3tm4odriHoG2r3PiOqY665HBXGgvJeg+PBVmjrPP42FXH3kH0sVm/IUnO4+OcfBIynvaXCaPmjygsTYXwQbY6PkEx3JcKW4IxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744976655; c=relaxed/simple;
	bh=yLGL8heeJcZC/qprBhd2ZylWzrlApzNJLo+TG+1mTxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhUSBnn53SVoRpoDGNLYckuZrSitz+crpN6IkavrbOSn7SvoFWewT3y7PC9yk4rk3lzoZFTFIlfJVjsMahTHaEBwgeicW5NoRtZWobA1ZMPm5O9bdZ1p0XcWSC48JtcKdg3banoaKEmBhMhCM64+lAhyXJGLYN49bf5MNc/AAKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZUcsCc+J; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1B02F40E0214;
	Fri, 18 Apr 2025 11:44:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rYyAgMN3oQD2; Fri, 18 Apr 2025 11:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744976646; bh=NiyydWlJa+7G6PPfSYX2cmaxmpcTnqGhtJ/YkVAp0rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUcsCc+J9b/Z3qxT8wwsuthJXu76krhBCibK+nYyvOxw2EK26O62Qb3FCSiOmPbas
	 tUUVOoBXS+4x+urIaDoEBx8B85J8QrOnYezfRHwFedW7H8f2Qqg1GNQzktoYgZLAwx
	 uCcE8UgcfuLzUTQpZJEEE6yNJWVadfoI7mwDdWlOx/Dj0+TvT9q2qhsZ+FZfhYVfq8
	 vApqN7iDP5PpI/ILfIS9WzdI5Z6sCsJRy4z6a26DV45EDB9AqoNJKaw3DlfCNud4Fd
	 SQk9ZvpL2+Jh6AK3JqXzIgQ0JLllmrHl0vHhiLbrtpttmS4eruw0H/vNqoYduE99Fl
	 FCUsbTCDyZcq27lb/I5B2c0p0KN2PvFBlATe4X7fhqf7wckBL6DUU3JkDCbpeBEr2k
	 gza13whx0EqU6dWWvDJpT+5TvV2/CR5avmvB2Bu9t8fG4373ez7FYpI2ajzeU4fAp1
	 p4/XqfcM8kAA+7POAF22efGuWKSSGx7kT3s8brYIyJIJGgSSn4rxKNsioXPY5qzqHN
	 wsTy6ufXPLiUKVA7jNpajeKitQgXzl27dwJU3b6OxwCWhBIQGY5/g+48T74cDJO+h/
	 c2XWyFF7OyrinsU7U7xBq7mrJmTXbWjCW1PDLUGKF2AEHCZHs3x08gw4Az8sa7ULzs
	 ueZckq+n7b9ujySIOr1YYPBo=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6391140E0200;
	Fri, 18 Apr 2025 11:43:56 +0000 (UTC)
Date: Fri, 18 Apr 2025 13:43:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: x86/alternatives] x86/efi: Make efi_enter/leave_mm() use
 the use_/unuse_temporary_mm() machinery
Message-ID: <20250418114350.GAaAI69qRzXARBY5tU@fat_crate.local>
References: <20250402094540.3586683-7-mingo@kernel.org>
 <174448360887.31282.4227052210506129936.tip-bot2@tip-bot2>
 <20250417141751.GAaAENj1RsBOtp2Tvb@fat_crate.local>
 <20250418095034.GR38216@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418095034.GR38216@noisy.programming.kicks-ass.net>

On Fri, Apr 18, 2025 at 11:50:34AM +0200, Peter Zijlstra wrote:
> Ah yes :-( Something like so perhaps..

Thanks, that does it.

Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

