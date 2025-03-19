Return-Path: <linux-tip-commits+bounces-4323-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 560DDA688D0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 10:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 178997A9BF5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0B01AB50D;
	Wed, 19 Mar 2025 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JzKpmuwD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2E20C46A;
	Wed, 19 Mar 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378072; cv=none; b=nnFq7Bat0OAlmk73M8nOkFgDPlBrYbD1jByHPDMKuLNKjYhV615u2btSesB/uTDghtb5snK6c3tShwv/yG8gVSXoOdJ1Ez1pa/KqBUj2mdwiH0wFj5vSKNmvMI2xhDlRcnrhFzsP7Rc9/+wUkN2qOL46E1S7AMTprN6O3AZez/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378072; c=relaxed/simple;
	bh=lcoJ/v4BNuTTqccAlT6cjQRIb0xerJabIpRrnhkHsKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUaEqYQB/9H1qE78kA/X5Gbi9sGgd+XicgXVMrIjxr/LsLJKyooyZ2v+4ehKimUUPJZUmj+5mKm5OXF41jqmCUmFJ2MsQ3npAfoRZNFfWq5/limVQ1irb8C0TuQnKthKB8Rrwz+bshlqKXk7n2fthxASgxxRw+EdEqPyoL13dj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JzKpmuwD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 31DE140E0196;
	Wed, 19 Mar 2025 09:54:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7o_IzpU70EBJ; Wed, 19 Mar 2025 09:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742378060; bh=WCsCMxOWpa+mMujFNfUXyDBBuoL0FWWVO1W19Vodfps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JzKpmuwDLK1ETFX64FYT4xFx9IikmURRnkz5ACuMJ13afZgaSouvNkf25lYnv6Pf4
	 CJk8dgqmTeheB9hOoDB3N7js8OyLZEwZ0INF4jPNWdSM9zyOIvMvSqYN5kiHKNoCEe
	 YqUDi0vGQ0Wb0ComGOwNZBtAAiMZg9yzTnjVr01ONoJ4ieEkbmneNuMV+05Jso3zwf
	 21cBF/7gjpEXSxzQpRWMbcqYG/qwxeq0UVQxvPmhA/WeY9XlLM6zxneO+qycBLJpmp
	 QtLx9YB8hnOQGtrQkcuQeHR0wLxXMRLsW9IBaOshTef026zpeLg6zBU3B1PxMEaAWt
	 6Xlo/73ycex0r6qaY3ZM6w/iESuH/qidl78nVP+r/+vpQzVGFURipWlGhsvR+geqX1
	 E/+d3LTM0LK4er7V7vacZ/H3l3/z48vDvctFmMNXPhVzRXVa75rsvN+CudgTyvt2cL
	 V31+GyYwoHmmttifB4hyJhsX7QLVqWZRgeIRGl9tzN2OT4tryJSZwfiFP6sZSp7o5n
	 BGIAL/s1oKU9yvgGF/eijdIDU7ub+VSnZp8MQHFWkSGLA5wJQkeKN89ecp9BwI7/ku
	 lrKF3xsJQKIBBvr2nWTlE0fdkjM080lzmNUUV9UB5IQpoQP61P4GzXFh2pNWnSysRr
	 /eoWf3DVNE81i5T7chPOBo+E=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 67C1340E015E;
	Wed, 19 Mar 2025 09:54:03 +0000 (UTC)
Date: Wed, 19 Mar 2025 10:53:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	xingwei lee <xrivendell7@gmail.com>,
	yuxin wang <wang1315768607@163.com>,
	Marius Fleischer <fleischermarius@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Xu <peterx@redhat.com>, x86@kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [tip: x86/mm] x86/mm/pat: Fix VM_PAT handling when fork() fails
 in copy_page_range()
Message-ID: <20250319095357.GAZ9qUNaWSORZMXdRK@fat_crate.local>
References: <20241029210331.1339581-1-david@redhat.com>
 <174100624258.10177.4534865061014070904.tip-bot2@tip-bot2>
 <fe0a67dc-d7cb-42ff-9b20-9527af7f6a94@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe0a67dc-d7cb-42ff-9b20-9527af7f6a94@redhat.com>

On Wed, Mar 19, 2025 at 09:15:25AM +0100, David Hildenbrand wrote:
> @Ingo, can you drop this patch for now? It's supposed to be "!get_pat_info"
> here, and I want to re-verify now that a couple of months passed, whether
> it's all working as expected with that.
> 
> (we could actually complain if get_pat_info() would fail at this point, let
> me think about that)
> 
> I'll resend once I get to it. Thanks!

That patch is deep into the x86/mm branch. We could

- rebase: not good, especially one week before the merge window

- send a revert: probably better along with an explanation why we're reverting

- do a small fix which disables it ontop

- fix it properly: probably best! :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

