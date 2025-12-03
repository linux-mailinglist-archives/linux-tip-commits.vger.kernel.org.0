Return-Path: <linux-tip-commits+bounces-7607-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C32FCA1687
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 20:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D578430053CC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 19:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FCD3191A8;
	Wed,  3 Dec 2025 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gR5TY1rQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95C3148C7;
	Wed,  3 Dec 2025 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789476; cv=none; b=CDKJ9ejlIC6T0Lx2tYwHDf9YNBjKlYqdz9P4BsqObh61B9R2rdafbBZj3q119GAUi5bQ0bJeaapW2bRxf7RqJYb8RQF+ormUPfO99D6ijSp4njKIah7rXdXZsaF9PNxBXV/kdC15/sOc2p+YSoOY7QrM9FXgxZXh4T21R/qrGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789476; c=relaxed/simple;
	bh=cq119+rufI9HsOFCPtp2I3KJFkEUVyzzn4usGpYeinM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARr0Qts4kHAhEeHis0dRhewt8z2QIWTU/dM1sTTgcdGZ+zJ9OW3npq1LvF1cFX6mw6iKEBl5Tg01jDTEgcGIPC2Z2/P9c9n89bTxrndWtOU0mOC4a0CWNIvQoS7WDT7oJhnd1beXEvc9y4y8U5KjizTq+f7sxvURAZyIqftqioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gR5TY1rQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7735BC4CEF5;
	Wed,  3 Dec 2025 19:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764789476;
	bh=cq119+rufI9HsOFCPtp2I3KJFkEUVyzzn4usGpYeinM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gR5TY1rQU3GWSEpX53Bz0gVUVeHtsYWdUdjPamvFnNPmFVbIDYI3oT3Xri6M5evqp
	 7CAKHQSnSNdCA0zEgFiJ0RRQp7H/E+TYTgDg9dOO6LnUH6C5JjmRF31KjbdycrwpBa
	 Bv3vrQdjj6GA6kOreLTJb7AOJ5egEYKzu1MtjKUy7h1jej2+kW5iFVadBlKH+Z2Zqx
	 i2apXaHkaQWHkPjbS95e9EOlP8FHdhagxccsf0YqBjJqIKLnF0wtCRhZy30PxvvF0m
	 sdeGE2l/lcfzkfWczYuyJRkI9xNpar7wzkE5HcQDLr+6qsVcjNmzME2R9V6AR3RkF3
	 Rx0rndS1YcdJg==
Date: Wed, 3 Dec 2025 11:17:53 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool: Consolidate annotation macros
Message-ID: <qhj7tqo35lo3fhl7ne5yl4pw6kp45c6owc75f4cj2gyxot2ldo@aizhulohwmmu>
References: <c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.1764694625.git.jpoimboe@kernel.org>
 <176478003405.498.13298696533128884255.tip-bot2@tip-bot2>
 <CAHk-=wgzL-bCggZOuDU7_f-1jpjus8Oaqtek9T8GdGUexnHYkg@mail.gmail.com>
 <aTBr3ImmrJQe4G49@gmail.com>
 <CAHk-=wjc4BeSu7dHB=5AuQNWQ=sOGAuH4j0=uRwsGyiSo+m+bw@mail.gmail.com>
 <72juhabxma7rw5eq2gglct4lmeoqfvrlv5jf36sdcfimz5rxxd@gnfuxdgv6stj>
 <CAHk-=wibTBOrb+T67uBCuXXQxDNtsS_KdMQCvgorUC1CPdHwzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wibTBOrb+T67uBCuXXQxDNtsS_KdMQCvgorUC1CPdHwzA@mail.gmail.com>

On Wed, Dec 03, 2025 at 10:41:30AM -0800, Linus Torvalds wrote:
> On Wed, 3 Dec 2025 at 09:46, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > So that mergeable thing is the only way to convince the toolchains to
> > allow setting the section entsize
> 
> Ugh. What a horrid reason. That *should* be trivially done by just
> having a linker script setting, but if one doesn't exist...

Believe me, I looked and there's surprisingly no way to do that from
linker script.

> What are the actual entry sizes, though? Because maybe we could just
> use alignment instead - which is trivially settable in the linker
> script.

That could work.  At least .altinstructions (14 bytes) and __ex_table
(12 bytes) aren't power of two.

We could certainly pad them, That does increase memory usage though.  On
my defconfig kernel that would add about ~11k.

-- 
Josh

