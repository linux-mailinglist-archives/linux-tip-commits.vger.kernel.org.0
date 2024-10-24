Return-Path: <linux-tip-commits+bounces-2533-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601189ADECA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 10:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F69A1C21EE2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 08:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886DE1AE005;
	Thu, 24 Oct 2024 08:14:33 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84EF14C5B3;
	Thu, 24 Oct 2024 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757673; cv=none; b=NhVSbKUFa0rvp9DmJplkMVecGxJ/ZWr98xswukdutBAHdwoJwZ/YibAVA/3ZUOdDk4jg1zHRb14m7mUOTOZ3Gzi0gRrt/84lxQXzoN3pJSz3fCKvEs0D4ojdn17f8wgGT7jsyFdb8lYqX5kC95yD9OVnnZMHYXbos8eeLcHvgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757673; c=relaxed/simple;
	bh=R+giDtgoTZeIOBH66q4LFLWeMzDuXsmv8So+huQMkLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2AIxt0HwwAlyKl0cVhKQTs9nRUrZ29xlgAcUtjzr6HsHhzXp2fM7CofnTxzxadLXEku6or+KaQk7gzwvycraTzLXwocdFqkucc8p1rADp8ptNRPAJwvcW4ukdaBuYlBKP8LZVf8zpwSVLV7G23U37nV+ZjGTCWnFSMI5zQnM20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 49O8CnMd029293;
	Thu, 24 Oct 2024 03:12:50 -0500
Message-ID: <e82c45088ed5aad81f44d4297ff19565e2472ba7.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Prundeanu, Cristian" <cpru@amazon.com>,
        K Prateek Nayak
	 <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar
 <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "Doebel, Bjoern"
 <doebel@amazon.de>,
        "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
        "Blake, Geoff" <blakgeof@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>, "Csoma, Csaba" <csabac@amazon.com>,
        "gautham.shenoy@amd.com"
 <gautham.shenoy@amd.com>
Date: Thu, 24 Oct 2024 19:12:49 +1100
In-Reply-To: <C0E39DE3-EEEB-4A08-850F-A4B7EC809E3A@amazon.com>
References: <C0E39DE3-EEEB-4A08-850F-A4B7EC809E3A@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-10-19 at 02:30 +0000, Prundeanu, Cristian wrote:
>=20
> The hammerdb test is a bit more complex than sysbench. It uses two
> independent physical machines to perform a TPC-C derived test [1], aiming
> to simulate a real-world database workload. The machines are allocated as
> an AWS EC2 instance pair on the same cluster placement group [2], to avoi=
d
> measuring network bottlenecks instead of server performance. The SUT
> instance runs mysql configured to use 2 worker threads per vCPU (32
> total); the load generator instance runs hammerdb configured with 64
> virtual users and 24 warehouses [3]. Each test consists of multiple
> 20-minute rounds, run consecutively on multiple independent instance
> pairs.

Would it be possible to produce something that Prateek and Gautham
(Hi Gautham btw !) can easily consume to reproduce ?

Maybe a container image or a pair of container images hammering each
other ? (the simpler the better).

Cheers,
Ben.

