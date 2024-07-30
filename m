Return-Path: <linux-tip-commits+bounces-1814-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50458940AB5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDD4DB242EE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E23F187568;
	Tue, 30 Jul 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaTDFEMa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A203187322
	for <linux-tip-commits@vger.kernel.org>; Tue, 30 Jul 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326657; cv=none; b=CHDxCC3cFzgqX6ON2MLDA+DgRYTVUxuJBjT4wwABLp+1l1QTMEiMIfy3M9uLB0oFzvJKZbYkvlfcWFNrOegQKh8stLI4aK2CcVFEfpOnm3Rhsmvt0KJliS/gO86be5rzmKKWc6NZsXyVpQ8Mp0Bmjmfebd7cuQN3EzhoRx1aPoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326657; c=relaxed/simple;
	bh=FqlJ9RhMzUPIg4sI1MoZrVvBhx3d6r55kj6apwzBlh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjfW2gu2KYi258ZgNQznhekJmSEeMjjbnLPHsFugtfqKHCt7c3iOdPQJJPZuA6g34fc4njmO0Www1YCz/Am9rM1lBV1GUv63FCeJIq81ZDiaV+KXVbleklRnK9gEkfv5ve7wpdTIRhwAjjS7nXmC1bXZXGQODoSXznV2o4E8nhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaTDFEMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A909C4AF0B;
	Tue, 30 Jul 2024 08:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722326656;
	bh=FqlJ9RhMzUPIg4sI1MoZrVvBhx3d6r55kj6apwzBlh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NaTDFEMagadHbLZCYQUI0zk7ACCeUMCSvaoKZORAzoJpys0JhnJlvqQFEmZlbXBk1
	 4PTKNUTv+pQbfFHuZz4KH7oLA8UUUTdIoOG9WYSQwGwp4YyfOh623XIkfGtDWz+RQp
	 rR2GrAARP00sCT9Tlrsh7qPtTw7HRbDj6aA1IjvbT/TH/jxxVuvsQqTZKOvwqXDYqm
	 LdAaqVFqxSzrfl9QzZ4BO0s2VY4zcgoaxSJ3ZbvaW0E73sZ8VJHOxEnrDuLO1FODrS
	 Mw9V9NZUG2z0yhzP72ezemeuh5ifctBckwnFb7jcD9kDbYlDilX8dyvarLe2gS1UO8
	 GwWZNt65IK28w==
Date: Tue, 30 Jul 2024 10:04:13 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip: irq/core] irqchip/armada-370-xp: Use consistent name for
 struct irq_data variables
Message-ID: <nl3hzgot4di5kkzfoy76vwmgz757nufd2kxfhzz4hxsrpkiyhh@ucftkhmbsphh>
References: <20240711160907.31012-4-kabel@kernel.org>
 <172224658230.2215.2389013389136353122.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172224658230.2215.2389013389136353122.tip-bot2@tip-bot2>

>  static int mpic_msi_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force)

You skipped this change of irq_data to d.

I also replied about this to the kernel bot error.

Marek

