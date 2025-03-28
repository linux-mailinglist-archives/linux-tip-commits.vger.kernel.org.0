Return-Path: <linux-tip-commits+bounces-4588-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA8CA7525C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 23:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABEAA189227E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 22:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C291EF387;
	Fri, 28 Mar 2025 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN3OTfT4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF91EF374;
	Fri, 28 Mar 2025 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743199903; cv=none; b=aMhC/UgAKbtWtA7CAQe41QIqP46+VRUtfVC/Pf6rjayJaeHFSnRilKf7KU4yOg2iCGeJcmg+4VxC8MfpoT+0SFngI9Fpc7/IgSeWZLHNDjRXXxlUUsVZDtoVcQFBX6fQpHS0FXEHuJQcrgINGKYrbW95OhQim8JM1insbvCF5K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743199903; c=relaxed/simple;
	bh=6ubRE10n/UOjIIs7EHR/cKNhb/utTvoMnslhTgiMcq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jotJMOA/4yCvg1i4e4VSDfy4ax/ARzBS+awac98LFt/B6oL5LgEnrCPxXAslgE8Tp/yfMAp6xyKusjESEYHic2UW9gBi033qnTlYkbCoSgS3lCHqI1VWlLTIhcg8Ys3JcbLdbp6q4WT6CbMqLFY69FSRuTsLpTlz3ZeDYysO+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN3OTfT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2834C4CEE4;
	Fri, 28 Mar 2025 22:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743199902;
	bh=6ubRE10n/UOjIIs7EHR/cKNhb/utTvoMnslhTgiMcq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mN3OTfT49h0Ybh65g9bQYoY4+eZPZbPc/Z7ElI2ITzwCQsxll3VIGR4HDZTFTVL26
	 Xghw5cefPEzKIpPILp2+TUBWJiBkhs9owQ3v8ULwqGSntffX/lYhY9N0i/7h2QpqT6
	 W0P2CpWSbG8bYfS3jv1TIu0J1UCXg8uyuA6CREmriWgY2H22x1tW76wKykSTy8GH/r
	 VJWA3JHEftMjLsdvkpMLtQ8kKqlfdzvPdugnnp2GxVwSYeLIrKwU3tB0iDvf2UOqvi
	 62Y8SMq6G8DhS5oomTKSQ75NJGIxAX7YdLZjo9o2bvXXpROYbkMNey1yFD0/Wc59KD
	 JPgtv+lVKm5YA==
Date: Fri, 28 Mar 2025 23:11:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-tip-commits@vger.kernel.org,
	Ondrej Lichtner <olichtne@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Herton R. Krzesinski" <herton@redhat.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/uaccess: Improve performance by aligning
 writes to 8 bytes in copy_user_generic(), on non-FSRM/ERMS CPUs
Message-ID: <Z-cemg4nGQDI3LXI@gmail.com>
References: <20250320142213.2623518-1-herton@redhat.com>
 <174319948654.14745.2953374115791547949.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174319948654.14745.2953374115791547949.tip-bot2@tip-bot2>


Linus,

* tip-bot2 for Herton R. Krzesinski <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     b5322b6ec06a6c58650f52abcd2492000396363b
> Gitweb:        https://git.kernel.org/tip/b5322b6ec06a6c58650f52abcd2492000396363b
> Author:        Herton R. Krzesinski <herton@redhat.com>
> AuthorDate:    Thu, 20 Mar 2025 11:22:13 -03:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 28 Mar 2025 22:57:44 +01:00
> 
> x86/uaccess: Improve performance by aligning writes to 8 bytes in copy_user_generic(), on non-FSRM/ERMS CPUs
...

> [ mingo: Updated the changelog. ]
> 
> Fixes: ca96b162bfd2 ("x86: bring back rep movsq for user access on CPUs without ERMS")
> Fixes: 034ff37d3407 ("x86: rewrite '__copy_user_nocache' function")
> Reported-by: Ondrej Lichtner <olichtne@redhat.com>
> Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/20250320142213.2623518-1-herton@redhat.com

I have added in Linus's Signed-off-by tag, to make this SOB chain 
valid. Let me know if that's not OK.

Thanks,

	Ingo

