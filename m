Return-Path: <linux-tip-commits+bounces-4211-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778DAA60E38
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 11:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6674D1B6089F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 10:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A41D1EEA46;
	Fri, 14 Mar 2025 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSDuHT2r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C761DF982;
	Fri, 14 Mar 2025 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946895; cv=none; b=JpoIAy39FsZgs2LNZXsbG/0rqm4q4OSMPd/H59oXk3jXz5QSQ25sA5TTb3YsPVgsuS0BX3kZbRdLQA4A90gVP04wUnjHynYMefDHB9QOud554U8vRi+mKduBVnwUdG/DQgjb85R/jiCoH5GTDCbohCf4+m8NTG36KNm4el4TkQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946895; c=relaxed/simple;
	bh=kn73f3ywP+3jWdjG+fmRIg/6UQjvehYiqYUuZrayPTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVyVvc/dd5SWMpJo2gDs607YPdsZunjNbKA8tZvJOdL2rxkexVwcRuw504ARJVazv1AUq03S2XsDC+WvKPBJXAfkwuy2UgFqXshudlP0eXZF2waImSHEk+eOg6iqnKWtulXZz8QX8qZWo0MUwbF9KwPnpyrovM32J28xr8hrdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSDuHT2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E5CC4CEE3;
	Fri, 14 Mar 2025 10:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741946894;
	bh=kn73f3ywP+3jWdjG+fmRIg/6UQjvehYiqYUuZrayPTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSDuHT2rSHENWVA7r/jAjADzJ10rstTHCzMn1KPzMKAQ+FKZBmvh6PdEbleyxtISe
	 0DkGmBCEY/ms3RH0C4mUZVHi2d0QAa25MCeB6h89r8tgspTM0kmdOtgtKFzuTC9AGb
	 Sb40ktifsFLotDSDapACdx16s7QJYRlcWSkOZSwb8ESXCSMYBtp5Cww1ARxHL6Hslb
	 SBPaEn3KN22dXVVJY+iQ63RnG6+xaA7IlVWskgqbXHjUrNux+iNEzySlD8VL3aTXII
	 YcCo9SeY8DRtIRtM8LwqO0j0WkgBsbP/K5gYIVl+cVWVNa0JoLVtgyCebfKwCUur9t
	 LP1WAf/WzyarQ==
Date: Fri, 14 Mar 2025 11:08:10 +0100
From: Ingo Molnar <mingo@kernel.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Brian Gerst <brgerst@gmail.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Subject: Re: [tip: x86/cpu] x86/xen: Move Xen upcall handler to Xen specific
 code files
Message-ID: <Z9QACrqCIxcZuY0U@gmail.com>
References: <20250313182236.655724-2-brgerst@gmail.com>
 <174194562029.14745.12496349660371729484.tip-bot2@tip-bot2>
 <c54d69f0-cda6-4793-bffb-1a0c1e5e9d92@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c54d69f0-cda6-4793-bffb-1a0c1e5e9d92@suse.com>


* Jürgen Groß <jgross@suse.com> wrote:

> On 14.03.25 10:47, tip-bot2 for Brian Gerst wrote:
> > The following commit has been merged into the x86/cpu branch of tip:
> > 
> > Commit-ID:     827dc2e36172e978d6b1c701b04bee56881f54bf
> > Gitweb:        https://git.kernel.org/tip/827dc2e36172e978d6b1c701b04bee56881f54bf
> > Author:        Brian Gerst <brgerst@gmail.com>
> > AuthorDate:    Thu, 13 Mar 2025 14:22:32 -04:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Fri, 14 Mar 2025 10:32:51 +01:00
> > 
> > x86/xen: Move Xen upcall handler to Xen specific code files
> > 
> > Move the upcall handler to Xen-specific files.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Link: https://lore.kernel.org/r/20250313182236.655724-2-brgerst@gmail.com
> 
> Why do I even request changes if such a request is being ignored?

I missed your mail, sorry.

> Please note that my request wasn't about something which should be 
> handled in a followup patch. I was asking to NOT move the code into 
> multiple files, but to keep it in one file as it was originally.

I agree with you that this code looks better in enlighten_pv.c, but 
there's no reason to keep arch/x86/entry/common.c, agreed?

I've rolled back these changes and will wait for -v2.

Thanks,

	Ingo

