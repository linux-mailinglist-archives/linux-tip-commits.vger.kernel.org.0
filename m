Return-Path: <linux-tip-commits+bounces-5454-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B220AAED1F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 22:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB649E2EA4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 20:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD5E28F95B;
	Wed,  7 May 2025 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N2imGAPo"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05428F947;
	Wed,  7 May 2025 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650202; cv=none; b=awvPOuO5rNtzvbEI+L9kWXzd86IbbfpSPBP7h7F0PSwL3Br5meu/bGdyynvO3XwZqCsPs5pyuK14aXm+G7S63g14FBVirJS12AtRv/ilst3WkqOpY23rsc6Su17adZ7v4s6KVFIEu//5KeqvkSzWFJ/QWVaof8WxY9uKfkACbeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650202; c=relaxed/simple;
	bh=ZGjelMgCgPH2Il8Xw+hIVNfck/csGvaiR7SmK/llZ1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HcLv9nvWxi0V8btj06zFzbaIvRZvHl1OGHzsM2zcWz9YGIEF8byJgV/nelsEV+aUDhShU7VPp11JqDMqhIvJERFbwRGUKnO9frsX7AzW9rZYUbx4WZKHOt7EN22wFCIbbctoWym9sX4HMGS7rkg96LuePtYL0LE+YCzkM3XuCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N2imGAPo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ebkk7je51it2yTRu26KTlGS0o/RB79MYisu9ONfqvPs=;
	t=1746650200; x=1747859800; b=N2imGAPoM0ABEkuh+powcmnzE7Ousc05Hqx2Qw+J3/LDYBx
	debF4Q4syrYJye6ylNVg9i5E8wu8ydyvz2/Mpy48s/hS5sy7/sKMyJkjVbeYwYYiwP/uMYjFRLMXv
	gapwvY/fPA8a8vr+z7NkyxkDvlw2+ycWGIlzBsqI2VZgvrsnkXfgs9WAquC2mVmjFiai507FlJi55
	6r5hPZ1NvUZWIuDQ4Yjd3p9sFrYilBTSxEdtM0ozy1mPNeRyneguoOTmKMqrLPwr8INKZorbZOjiA
	594hC6Smntj88TJASNgYq4Mif59AKvyX6QqqroFKx21NVgqaZJ8aW7oM8NnqhF/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uClVH-00000008YNN-1Tjh;
	Wed, 07 May 2025 22:36:31 +0200
Message-ID: <007a7132d1396912b1381e96cc4401a10071ed24.camel@sipsolutions.net>
Subject: Re: [tip: x86/msr] um: Add UML version of <asm/tsc.h> to define
 rdtsc()
From: Johannes Berg <johannes@sipsolutions.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-tip-commits@vger.kernel.org"
	 <linux-tip-commits@vger.kernel.org>
Cc: lkp <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>, "x86@kernel.org"
	 <x86@kernel.org>, linux-um@lists.infradead.org
Date: Wed, 07 May 2025 22:36:30 +0200
In-Reply-To: <174664324585.406.10812098910624084030.tip-bot2@tip-bot2>
References: <202505080003.0t7ewxGp-lkp@intel.com>
	 <174664324585.406.10812098910624084030.tip-bot2@tip-bot2>
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

+linux-um

On Wed, 2025-05-07 at 18:40 +0000, tip-bot2 for Ingo Molnar wrote:
>=20
> To resolve these kinds of problems and to allow <asm/tsc.h> to be include=
d on UML,
> add a simplified version of <asm/tsc.h>, which only adds the rdtsc() defi=
nition.

OK, weird, why would that be needed - UM isn't really X86.

>  arch/um/include/asm/tsc.h | 25 +++++++++++++++++++++++++

Feels that should be in arch/x86/um/asm/ instead, which I believe is
also included but then at least pretends to keep the notion that UML
could be ported to other architectures ;-)

> +static __always_inline u64 rdtsc(void)
> +{
> +       EAX_EDX_DECLARE_ARGS(val, low, high);
> +
> +       asm volatile("rdtsc" : EAX_EDX_RET(val, low, high));
> +
> +       return EAX_EDX_VAL(val, low, high);
> +}

Though I also wonder where this is called at all that would be relevant
for UML? If it's not then perhaps we should just make using it
unbuildable, a la

u64 __um_has_no_rdtsc(void);
#define rdtsc() __um_has_no_rdtsc()

or something like that... (and then of course keep it in the current
location). But looking at the 0-day report that'd probably break
building the driver on UML; while the driver doesn't seem important we
wouldn't really want that...

Actually, that's just because of the stupid quirk in UML/X86:

config DRM_ACCEL_HABANALABS
        tristate "HabanaLabs AI accelerators"
        depends on DRM_ACCEL
        depends on X86_64

that last line should almost certainly be "depends on X86 && X86_64"
because ARCH=3Dum will set UM and X86_64, but not X86 since the arch
Kconfig symbols are X86 and UM respectively, but the UML subarch still
selects X86_64 ...


I dunno. I guess we can put rdtsc() into UML on x86 as I suggested about
the file placement, or we can also just fix the Kconfig there.

johannes

