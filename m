Return-Path: <linux-tip-commits+bounces-8-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8747A80EF09
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Dec 2023 15:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1681EB20DF9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Dec 2023 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB60745C8;
	Tue, 12 Dec 2023 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hCzGva0q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rAOSq9Pl"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34D8EA;
	Tue, 12 Dec 2023 06:41:49 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702392108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cjPK7MVMgy2ptbwUtlp8hX92DZpbm09HrB3RqKSh7c=;
	b=hCzGva0qLyY2C794F9jreEi1PD8bHm/7vc2zgjOo66QgbykdqHgb4wGk0RaEJhMI+7W54z
	+NYLWcjI5Y5AXNwoEnl3jvaDcmBgJQDDr7PADCO6kQwqeOwkdmAocWluYzUQCYQUFYlxfh
	Q0Ikm6ZEYxj9IHLk1iGRyexe+8YY8aZmTf5L0TTz7KynsISTAJdp6LDADZwqmh6j+wefyb
	88ieBJQN7PRqQnjvL1UAeQObMSc1gQQlcc0hzfvlSKRvtUkOZSlKlVZLiApec5w+zp2ix8
	64KIld3svU96A6McyGVJpYr7Mnkixau9BoNEWnssHQ5IoI36VIpHMVmoN4A+NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702392108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cjPK7MVMgy2ptbwUtlp8hX92DZpbm09HrB3RqKSh7c=;
	b=rAOSq9PljTxW1TWf7+dIHC1trcyKTaG3HqffG6HSHU3USgY3wtPbHOQ4zC6GYi9Ve0cz+e
	hZKuJH22Z+TwoABg==
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-tip-commits@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Subject: Re: [tip: irq/core] arm64: dts: renesas: r9108g045: Add IA55
 interrupt controller node
In-Reply-To: <CAMuHMdUgvP9x3eTcvAnxYtH-79Mfb585EJOBYOyev_w0xfCZEg@mail.gmail.com>
References: <20231120111820.87398-10-claudiu.beznea.uj@bp.renesas.com>
 <170207007858.398.5775493085982200914.tip-bot2@tip-bot2>
 <CAMuHMdUgvP9x3eTcvAnxYtH-79Mfb585EJOBYOyev_w0xfCZEg@mail.gmail.com>
Date: Tue, 12 Dec 2023 15:41:47 +0100
Message-ID: <877cljqy8k.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Geert!

On Sat, Dec 09 2023 at 17:24, Geert Uytterhoeven wrote:
> On Fri, Dec 8, 2023 at 10:16=E2=80=AFPM tip-bot2 for Claudiu Beznea
> <tip-bot2@linutronix.de> wrote:
>> The following commit has been merged into the irq/core branch of tip:
>>
>> Commit-ID:     8794f5c3d2299670d16b2fb1e6657f5f33c1518c
>> Gitweb:        https://git.kernel.org/tip/8794f5c3d2299670d16b2fb1e6657f=
5f33c1518c
>> Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> AuthorDate:    Mon, 20 Nov 2023 13:18:20 +02:00
>> Committer:     Thomas Gleixner <tglx@linutronix.de>
>> CommitterDate: Fri, 08 Dec 2023 22:06:35 +01:00
>>
>> arm64: dts: renesas: r9108g045: Add IA55 interrupt controller node
>
> Please do not apply Renesas DTS patches to your tree without an
> explicit ack.
> Renesas DTS patches are intended to go in through the renesas-devel
> and soc trees.

Sorry. I had the impression this all belongs together. I zapped 1/9 and
9/9 and force pushed the branch. Should be gone in tomorrows next

