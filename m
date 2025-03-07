Return-Path: <linux-tip-commits+bounces-4054-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD3DA575BF
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 00:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112033AA9BA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 23:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D32208989;
	Fri,  7 Mar 2025 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n69nen5U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F319006F;
	Fri,  7 Mar 2025 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388736; cv=none; b=oxTMY5IedoNN8XN8t9OuF4A1zpc8NLB2EYVKYyE2YUia49yaC9fwPmWUmtyp+HYlNpKbwBn/DPxD8ILeXg3UNGUKnmdiFoa+RgJon5XpyfoX1lKC5YJsS5xjmFhyUbuiQk0OzfRgxkezB0r4iHB0XbZqBnuU8YaUvvwy0hmnij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388736; c=relaxed/simple;
	bh=xkz0UTREMr5lxZRm0L2JACHrFzJS6kI42IRiXa/YOr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cjrrn8aTPgOCJWysTA9GjiaYtoNEqBpmWivC71DB0wQ2jmWbGkmKl8WVM/RoWWX8X3YdHBGZZWQ9qHsKilM0uMPP1kDm4RjZrTvsWxWcNXqWTZRYfz7Q6c03IFmlBtO7T04rIWCCATxB8TNNsarKtcedmxoGFYUqIKLjp6czOlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n69nen5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A92C4CED1;
	Fri,  7 Mar 2025 23:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741388734;
	bh=xkz0UTREMr5lxZRm0L2JACHrFzJS6kI42IRiXa/YOr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n69nen5UF3U337rjqyCm1+pgToPzrl7eRyd7RDoyG7mtCQItKuOBezHuuRk9KVHWI
	 gbFwWCh65f451dr5V+oMChsBvecLABr5fJtV6WD9ra8IHG7tjvpJ6nqCqMIzTB5BMa
	 LzdDG42g4ElmeLhFwMpgN6r52UrfUZkank4h1QPJzDSpAPZR3GIkCAPe3ZR3A/bN7G
	 bUDhoaOkbS/I45Dy7DKjSjtkGzFqhJG2j4u5+gXUqnz9F//hJowrGEWepVWksvVO8M
	 r0hYx03q3pEcvWUr/1SmWTvVkoR2KQQ4bIU0t692aT+OA/lX6psu9xmNZokBUQV7Sp
	 /9raIowvr8Rnw==
Date: Sat, 8 Mar 2025 00:05:29 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
	linux-tip-commits@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>, x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <Z8t7ubUE5P7woAr5@gmail.com>
References: <174108458405.14745.4864877018394987266.tip-bot2@tip-bot2>
 <90B1074B-E7D4-4CE0-8A82-ADEB7BAED7AD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90B1074B-E7D4-4CE0-8A82-ADEB7BAED7AD@zytor.com>


* H. Peter Anvin <hpa@zytor.com> wrote:

> > #endif /* __ASSEMBLY__ */
> 
> So we are going to be using this version despite the gcc maintainers 
> telling us it is not supported?

No, neither patches are in the x86 tree at the moment.

Thanks,

	Ingo

