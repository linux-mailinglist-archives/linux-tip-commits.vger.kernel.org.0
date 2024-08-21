Return-Path: <linux-tip-commits+bounces-2091-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCEF9598B0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Aug 2024 12:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1A128418A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Aug 2024 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6021E9191;
	Wed, 21 Aug 2024 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hJxTH4Ky";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LD2MH5rP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD931E9185;
	Wed, 21 Aug 2024 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232430; cv=none; b=mzYmnUEgG45Xs/wLIFiU4QtG2dZpkLuCaiXbkJaEtw7YVFHPtrcticeJFpnmtgjtYILyOq/6dBdfK5KE7L+TtVljwaq8GMGTCH9loWUz9Rqj/qyWCSjWHusINvol0m5ynNxUVyOzOMyMQetBpX/ffanFoXeNOjFIpMyyj+XQUXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232430; c=relaxed/simple;
	bh=RPGFaH1SBxiVhtImrgkAvOBcxPJ5Iz+uylz4nMVpLdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QBrUUhFso61OUjP8+mUYtvgZtvZQTVfXsRhelUr2mhvWMTpFFTeQfd2FILmlUPKVCTsqIpUYDLDB4TpIvwmPV6+IdVsfgLoioFSUCtcrYGISJ28K0k0uNqTRhIDy7TPYXv6qTB+0V0WlrM9Go4ZfnUmXsFBsSMXmoBFBhImj+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hJxTH4Ky; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LD2MH5rP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724232426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20sOxGWWYbRCe3Ey0/mymw055MV5SMyuuex1Gz0yYP0=;
	b=hJxTH4KysKbJZupxoXspk2yjAP1BMPYDyEsJX1FA4bmvF39jtRlEUSCRIQsMlM7rzfGBQO
	/1aHdNRVidmIDy77eRnCiza4B/Gxb0i692X9aBvEMTha9hnnQ3wFjN+f7ZTRMl3pc4Ri5f
	JVz3eMBfg9ftEDpganYsU3EJ7UrvUiz6SsXgcZF3UdGzpr9XpUdaB2ni3Ispr4DbPKEW9c
	9OXzjptVNFp/GgK0d8gHAzj8g34v/vzPt07lcYLGfnPl3RrPA40BAFUb7wsP//qTbb+VM7
	8afw1oQilZsrOm6eEB+xFlQLH2nx0kZ18TIRUD9ReuAEOKQbLTmlfnAf7keZ8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724232426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20sOxGWWYbRCe3Ey0/mymw055MV5SMyuuex1Gz0yYP0=;
	b=LD2MH5rPPTKJU4agm9BLYg+aJyHRrvJlCEIt6eH4mM+boh80nqrie+mPZa3y+ZC/UfBG0N
	FmVa/yNr5c4rteDg==
To: Max R <max8rr8@gmail.com>
Cc: tip-bot2 for Max Ramanouski <tip-bot2@linutronix.de>,
 linux-tip-commits@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Alistair Popple <apopple@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/urgent] x86/ioremap: Use is_ioremap_addr() in iounmap()
In-Reply-To: <CAJrpu5n5ReFCWrtAYsWpneAb+g6hAs4E-NeFh40chJfArEsioQ@mail.gmail.com>
References: <20240815205606.16051-2-max8rr8@gmail.com>
 <172380142877.2215.11720831620589167404.tip-bot2@tip-bot2>
 <87a5h7j5l1.ffs@tglx>
 <CAJrpu5n5ReFCWrtAYsWpneAb+g6hAs4E-NeFh40chJfArEsioQ@mail.gmail.com>
Date: Wed, 21 Aug 2024 11:27:05 +0200
Message-ID: <875xrujkeu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 21 2024 at 11:35, Max R. wrote:

Please do not top-post and trim your replies.

> Apparently,  x86-32 doesn't provide VMALLOC_START in asm/pgtable.h,
> and after a quick glance it seems to be the only arch to do so...
> Probably the correct solution is to add include asm/vmalloc.h to
> include/linux/ioremap.h, considering it uses VMALLOC_START. Will
> resubmit the v4 version of patch later today.

Careful, this might end up with other issues vs. the kernel header
inclusion hell.

If i386 is the only one which does not have VMALLOC start in
asm/pgtable.h, then curing this might be the easier fix, no?

Thanks,

        tglx

