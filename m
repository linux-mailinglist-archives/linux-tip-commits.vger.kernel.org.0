Return-Path: <linux-tip-commits+bounces-6-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D525A80EDF5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Dec 2023 14:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3981F21369
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Dec 2023 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4562E6ABAD;
	Tue, 12 Dec 2023 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPDizaqp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2809961FCC
	for <linux-tip-commits@vger.kernel.org>; Tue, 12 Dec 2023 13:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D18DC433C7;
	Tue, 12 Dec 2023 13:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702388821;
	bh=mqxh9zunvpb036JZEOLxMSrfLM8AML7StjISr8/NUDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPDizaqpMsgAC2wnSd8hWh+uF/U5C1z1oKAH5P9f6P0IJXDjXBHa0BJJF6i2tfiNf
	 keSo51yS8RBVKsLDWYkEpWFsCCdadst98HelLd695zkEMwY1C3gDAvLtopVA/ECXrf
	 uwTfxOnAkA+Pps0AKRTPrc2kB5MuacVnNE8xYlHdVjOlYFoqL6MTZvnSOlr1DY+Eov
	 279NiCHsiGwme2XmVmu7HB0YSqUSmy6GBYMY1/3a6sQVzBpgi0xjvDo4eyRqWsmWNp
	 CU/zAbXQznnX3/dj2e48O5Xp2boLbHWjdN1e69iGTs5k0krjDe/WMWotoLZW8Frv/M
	 BASwnQ0dHZRuA==
Date: Tue, 12 Dec 2023 14:46:58 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Cooper <Andrew.Cooper3@citrix.com>,
	linux-tip-commits@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/core] x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer
 reprogram
Message-ID: <ZXhkUshO49ldjBio@lothringen>
References: <20231115151325.6262-3-frederic@kernel.org>
 <170126975511.398.12493947150541739641.tip-bot2@tip-bot2>
 <20231130111519.GA20153@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130111519.GA20153@noisy.programming.kicks-ass.net>

On Thu, Nov 30, 2023 at 12:15:19PM +0100, Peter Zijlstra wrote:
> This is so, because all mwait users should be in __cpuidle section,
> which itself is part of the noinstr section and as such
> kprobes/hw-breakpoints etc.. are disallowed.
> 
> Notable vmlinux.lds.h has:
> 
> #define NOINSTR_TEXT							\
> 		ALIGN_FUNCTION();					\
> 		__noinstr_text_start = .;				\
> 		*(.noinstr.text)					\
> 		__cpuidle_text_start = .;				\
> 		*(.cpuidle.text)					\
> 		__cpuidle_text_end = .;					\
> 		__noinstr_text_end = .;

So #DB aren't supposed to happen then, right? Or you noticed an mwait
user that doesn't have __cpuidle?

Thanks.

