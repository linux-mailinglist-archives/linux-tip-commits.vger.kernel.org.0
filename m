Return-Path: <linux-tip-commits+bounces-5459-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165B0AAF640
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 11:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850821BC55F0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 09:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A4B262FE5;
	Thu,  8 May 2025 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="db5j4QU1"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F44525484D;
	Thu,  8 May 2025 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694943; cv=none; b=rk+NQkRAXbdZqorxRGM9Wve0ioN7ChlFk8ioZvR4vBd4KOtiJeJkMG7JJ65QDjbRCeIKc4JOM45n5Uk5K/xXz2vClvyAJWb4L+tNrx1KUMGEVg/iP6VWTKYYYWQe3YUAzbLITvr/CEEsAv3FZp5Wb6RecMxzb85pJqFLmE9VmcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694943; c=relaxed/simple;
	bh=8Rypyay4AhyqMCAVMP7o+y3EI6xc+qzYvwlMDd5Jl4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hn65FER1K70S5mGKeBQsIoe3Bsco4di8vxX6fEiZCAS1tjp7nsBdVCVQZMY9sDfuopHc5Wz/R8KjVVCtFz67xyI8ApYgQIGL4SgXLAIJ1QjyPCPFZN/F6yxumInIbtn2Qfl5XNRJbiLtWzankAhb6gAGnKzhvgODv9O9up5elNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=db5j4QU1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8Rypyay4AhyqMCAVMP7o+y3EI6xc+qzYvwlMDd5Jl4g=;
	t=1746694941; x=1747904541; b=db5j4QU1Unter884lEnf9/ruPxiS+GXznWMJr2DlCw5Yza9
	gutc5XMeM306ZN+Xvjawcw91Y3bOAnQ28U+og7WKYHn3Pdolos8lPsAZPqX+VpWAszrZCBSVK/24R
	nbZWHaqTzAmeZKjUKi7kMbYXbSdgTkDN46APlG9/X98LD+BsY6ozsVsjttVKhobh7Mvi2UJ9xe5ze
	FGJr82tpBAzlX6lezvwfHCa7f+UOI1GzmyQLBaetIz8icRkZID9E1wcEIxGPfcXuCDq4FwgO4wloT
	mDHiDZ9nZPdcag6kmjvNOp9Ds83ttAtWCya95PwYwX25+HkE5xIVkMUDDHRCrK9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCx90-00000009zND-059U;
	Thu, 08 May 2025 11:02:18 +0200
Message-ID: <709b486f4cfb93e0feac12300e4f06a34f49fd27.camel@sipsolutions.net>
Subject: Re: [PATCH -v2] accel/habanalabs: Don't build the driver on UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-tip-commits@vger.kernel.org"
	 <linux-tip-commits@vger.kernel.org>, lkp <lkp@intel.com>, "x86@kernel.org"
	 <x86@kernel.org>, linux-um@lists.infradead.org
Date: Thu, 08 May 2025 11:02:17 +0200
In-Reply-To: <aBxyDyVT5QbOlhPq@gmail.com>
References: <202505080003.0t7ewxGp-lkp@intel.com>
	 <174664324585.406.10812098910624084030.tip-bot2@tip-bot2>
	 <007a7132d1396912b1381e96cc4401a10071ed24.camel@sipsolutions.net>
	 <aBxyDyVT5QbOlhPq@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-05-08 at 10:57 +0200, Ingo Molnar wrote:
> >=20
> > I dunno. I guess we can put rdtsc() into UML on x86 as I suggested abou=
t
> > the file placement, or we can also just fix the Kconfig there.
>=20
> The Kconfig solution looks much simpler to me too :)
>=20
> Patch attached, does this look good to you?

Yeah looks good to me. Common gotcha really.

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

If anyone _really_ needs to have this driver built on UML (say for
simulations/testing, we do build iwlwifi for all the time), then they'd
probably want to replace the rdtsc() anyway with something else there.

johannes

