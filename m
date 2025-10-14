Return-Path: <linux-tip-commits+bounces-6804-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0544CBD9E7C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 16:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAC91886425
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 14:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C023E314B9F;
	Tue, 14 Oct 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aXY5WbjU"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7C7309F08
	for <linux-tip-commits@vger.kernel.org>; Tue, 14 Oct 2025 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450949; cv=none; b=jOltWGBsllEDo2XrXnxwizh0/RUE22bvT1p3YAPT0U/cjCb7ItbEyOdynuKtwNHNu2+gaMikG6Gr/E27QH/VlI6wGEnqlk6kGPDjliYRVdFwWUC5fuIHoS175V1vRD/5aM/bGJh6fETDSUm3kMNhoZlQK27UhCH0+w04JbKXU8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450949; c=relaxed/simple;
	bh=29vPk9G2442S1XTcsoTAlAV0GmlKmUuYJsyfuscY2/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGNYLlyveZH9hhIB6QIG4ojRRwR1RDZuk+n7SI4zTEL45QFlOw4dgySzLTRUoR6IYJQA9K6MKN3dlZdjrmbQORawQhPJXmyJEbtfndwq5/rxvGw1q+9rsqOyPV+wuGB3g4beyUDBfpF3c016q5+obK4i4eR+E0wukx9mCgBVf/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aXY5WbjU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63be5c739cdso376927a12.2
        for <linux-tip-commits@vger.kernel.org>; Tue, 14 Oct 2025 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760450944; x=1761055744; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=29vPk9G2442S1XTcsoTAlAV0GmlKmUuYJsyfuscY2/s=;
        b=aXY5WbjUvbBfAqDFf+JBRh07CpOOTZybLt/St/N9cy8ZXmKol2IxNMjWj2j7IJTBNc
         k7n4SNK58vJE1DEOoDUWylbOxlFS82QqLzBnFgzqqS9RPZfQJ0kVclTG1xI/5JUdIiEK
         lCUYSHHli/JCWfU8tdMxFMROLThdSQyO7jVJoG7RalR9yLHB0bkZYb/skVAsU0opQdzO
         2u9/bLvHadBfxlzzJ7AtzF95OKal1DXRPx72jOYKGi82Rk3rFiWwPuxJJdIIGwhj0n4W
         l9MKgpjSS9bHo+Fd4DNzxYpBoiByrpWlNEiRkcaa0p9w3jdZODI15xEIHE4utZMs+ZF6
         RLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760450944; x=1761055744;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29vPk9G2442S1XTcsoTAlAV0GmlKmUuYJsyfuscY2/s=;
        b=tdZ1P/cZQ5UWJsqra/SccxKpAYgwvs5Xr1qysRICwozaKLKCn4E9Qd3u+/GPsthOX6
         atK4ebSlxUkR1oqoiZqfCByUmlFkSx4tIwBe85niqLX2gl6ncZnb/oFkbjBIPXxMFcxW
         Kq82bmJwFo8xNa7CFt1RE3E8pwqKSVbZdeqwn2g0E//EH8CUpUqpwziQIKYzF0Th5wMn
         ksAo8FyHb+B+r2qKJdkXlQWZP0GNvtaNrHwVevaDEb7sgRBdMjupJy6QMtp8DvqXVZyu
         pWYRGBjZPaVdiuL/Z8EmDgSDT+n6sX9q6yKIV/OeLT22bVdbaZbSJ5dZW2D9ePrm+4Bb
         PHgg==
X-Gm-Message-State: AOJu0YydcqXODnhH58OcGH+u8L+PCM4vpYblazp+ndVCuXQ0QoRyphUt
	40LkstdO/BSYB8rUIJMSMAb8L9qRa9JvPTHvmsSGUSn4qJgdJw9IBe+S5QchhES12HM=
X-Gm-Gg: ASbGncsUEKpTbJb4eqfe48ZxA41kJX0/IQodPPbIPOqu/y9uADM0trUS11dZI3Jlq+p
	KmiyQtW3f0dzrpoz1ouLU6VDg/htUTszK6IxMEiKHEc4lVAFiOO2HDuAo8TiYnEPpKtn/hBuixq
	rthz5SPZULbqTDsdLSel2zoTwnFCAJM+xJ9ISylJ9lsWhSANi144YMmfB4UK2JgVD056McL2IEQ
	CXvWNxgRKgj6i/VdfLD8wfDIagDjGk1mNi2p3g9kNAA8ZJGhEKOU8na2OKDfv3D/Ai+WzAGXGqv
	zrjup+ACs8ck5kcb0zrgNMuQnodZYOyTdclgwYLLUNP9pt8/QSQXCdTBDoOhqDfFlusv8YTIXmo
	hg0wHqEOdnE4ntYIoBlB96bRvO0TJ1LI9LeipZmOHhR0+YhHSDCURhnrupNQsuKMMLp2qUSlSYK
	3TPjDeYCXjHbUHDixM4V5m2a6wgvc9g7eDkWer9PgSdjvZ0ADo5ZCJHSIuy1M2q9CY+ANrbDlQJ
	Q==
X-Google-Smtp-Source: AGHT+IHVoSbNtc0mRK8bRhf5xEKEPdvnGDjmzAL8y/QJaV16Ye5OTYwKCM6v0zEL7sIjL8k+aNjE5g==
X-Received: by 2002:a17:907:6ea8:b0:b24:7806:b59 with SMTP id a640c23a62f3a-b50ac9f86f9mr2731042666b.55.1760450928736;
        Tue, 14 Oct 2025 07:08:48 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f750sm10984521a12.14.2025.10.14.07.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:08:48 -0700 (PDT)
Message-ID: <4fd058ac-3af5-4778-842c-9a185d828c9d@suse.com>
Date: Tue, 14 Oct 2025 16:08:47 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
To: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Ne1Q5ccXkKsnDC4xcJfv8OOR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Ne1Q5ccXkKsnDC4xcJfv8OOR
Content-Type: multipart/mixed; boundary="------------CKaEDbfsE20oI2qb3t0z002d";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Message-ID: <4fd058ac-3af5-4778-842c-9a185d828c9d@suse.com>
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
In-Reply-To: <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>

--------------CKaEDbfsE20oI2qb3t0z002d
Content-Type: multipart/mixed; boundary="------------0HsMH0PnhrAXNen0kb0M9MG0"

--------------0HsMH0PnhrAXNen0kb0M9MG0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMTAuMjUgMTQ6NTksIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBP
Y3QgMTQsIDIwMjUgYXQgMDg6NDI6MzRBTSAtMDAwMCwgdGlwLWJvdDIgZm9yIEp1ZXJnZW4g
R3Jvc3Mgd3JvdGU6DQo+PiBAQCAtNjQ4LDYgKzY0OCw4IEBAIHZvaWQgX19pbml0X29yX21v
ZHVsZSBub2lubGluZSBhcHBseV9hbHRlcm5hdGl2ZXMoc3RydWN0IGFsdF9pbnN0ciAqc3Rh
cnQsDQo+PiAgIAl1OCBpbnNuX2J1ZmZbTUFYX1BBVENIX0xFTl07DQo+PiAgIAl1OCAqaW5z
dHI7DQo+PiAgIAlzdHJ1Y3QgYWx0X2luc3RyICphLCAqYjsNCj4+ICsJdW5zaWduZWQgaW50
IGluc3RhbmNlcyA9IDA7DQo+PiArCWJvb2wgcGF0Y2hlZCA9IGZhbHNlOw0KPiANCj4gRXhj
ZXB0IHRoYXQgd2UgaGF2ZSB0aGUgcmV2ZXJzZSBmaXIgdHJlZSBydWxlIGluIHRpcCBmb3Ig
ZnVuY3Rpb24tbG9jYWwgdmFycy4NCg0KT2theS4NCg0KPj4gQEAgLTY5MiwxNCArNjk4LDE5
IEBAIHZvaWQgX19pbml0X29yX21vZHVsZSBub2lubGluZSBhcHBseV9hbHRlcm5hdGl2ZXMo
c3RydWN0IGFsdF9pbnN0ciAqc3RhcnQsDQo+PiAgIAkJICogLSBmZWF0dXJlIG5vdCBwcmVz
ZW50IGJ1dCBBTFRfRkxBR19OT1QgaXMgc2V0IHRvIG1lYW4sDQo+PiAgIAkJICogICBwYXRj
aCBpZiBmZWF0dXJlIGlzICpOT1QqIHByZXNlbnQuDQo+PiAgIAkJICovDQo+PiAtCQlpZiAo
IWJvb3RfY3B1X2hhcyhhLT5jcHVpZCkgPT0gIShhLT5mbGFncyAmIEFMVF9GTEFHX05PVCkp
IHsNCj4+IC0JCQltZW1jcHkoaW5zbl9idWZmLCBpbnN0ciwgYS0+aW5zdHJsZW4pOw0KPj4g
LQkJCW9wdGltaXplX25vcHMoaW5zdHIsIGluc25fYnVmZiwgYS0+aW5zdHJsZW4pOw0KPj4g
LQkJfSBlbHNlIHsNCj4+ICsJCWlmICghYm9vdF9jcHVfaGFzKGEtPmNwdWlkKSAhPSAhKGEt
PmZsYWdzICYgQUxUX0ZMQUdfTk9UKSkgew0KPj4gICAJCQlhcHBseV9vbmVfYWx0ZXJuYXRp
dmUoaW5zdHIsIGluc25fYnVmZiwgYSk7DQo+PiArCQkJcGF0Y2hlZCA9IHRydWU7DQo+PiAg
IAkJfQ0KPj4gICANCj4+IC0JCXRleHRfcG9rZV9lYXJseShpbnN0ciwgaW5zbl9idWZmLCBh
LT5pbnN0cmxlbik7DQo+PiArCQlpbnN0YW5jZXMtLTsNCj4+ICsJCWlmICghaW5zdGFuY2Vz
KSB7DQo+PiArCQkJaWYgKCFwYXRjaGVkKSB7DQo+IA0KPiBJIGRvbid0IHNlZSBob3cgdGhp
cyBpcyBtYWtpbmcgdGhpcyBjb2RlIGJldHRlciAtIHRoaXMgaXMgc2xvd2x5IHR1cm5pbmcg
aW50bw0KPiBhbiB1bnJlYWRhYmxlIG1lc3Mgd2l0aCB0aG9zZSBtYWdpYyAiaW5zdGFuY2Vz
IiBhbmQgInBhdGNoZWQiLg0KPiANCj4gQW5kIGZyYW5rbHksIHRoZSBqdXN0aWZpY2F0aW9u
IGZvciB0aGlzIHBhdGNoIGlzIGFsc28gbWVoOiBhbiBpbnRlcnJ1cHQgbWlnaHQNCj4gdXNl
IHRoZSBsb2NhdGlvbj8hPyBJZiB0aGlzIGlzIGEgcmVhbCBpc3N1ZSB0aGVuIHdlIGJldHRl
ciBkaXNhYmxlIElSUXMgYXJvdW5kDQo+IGl0LiBCdXQgbm90IG1ha2UgdGhlIGNvZGUgeXVj
a3kuDQoNCkZvciBvbmUgaXQgaXMgbm90IHRoZSBvbmx5IGp1c3RpZmljYXRpb24uDQoNCkFu
ZCBqdXN0IGZvciB0aGUgcmVjb3JkOiBOTUkgaGFuZGxpbmcgaXMgdXNpbmcgQUxURVJOQVRJ
VkVfMiwgc28geW91DQpjYW4ndCBqdXN0ICJkaXNhYmxlIGludGVycnVwdHMiIGFuZCBiZSBz
dXJlIGl0IHdpbGwgd29yay4NCg0KDQpKdWVyZ2VuDQo=
--------------0HsMH0PnhrAXNen0kb0M9MG0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------0HsMH0PnhrAXNen0kb0M9MG0--

--------------CKaEDbfsE20oI2qb3t0z002d--

--------------Ne1Q5ccXkKsnDC4xcJfv8OOR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjuWW8FAwAAAAAACgkQsN6d1ii/Ey82
sgf9FhNJkhPx3Fi0EcG1eZajzmknuqCyoU9musIZVnJosxwWZ8u92cz8EJ+7KtwgPr8pgcw1SgB7
IVbhNtJStSqEm+MPig4bfOnlnsW2tZqL6Qv922zkqP5uNTx93qPGrrKcCHzM8F9RsqSkQhnUyPl3
RaFzEK81l1V4Vv29Yi6qnV5QoFpceQK+4ZZ//bMlmZkCWcvcv5QT+RsoTIZqaNLipG3cD/R2C58S
8o5hNeT5//5KCP5w+gZs+G3h3bn/JX7NphJqCId1xD9cqgnewllcxMEc1gW3dUvBsFiKUeBEhKiK
5TcdESJxQDy41hcWUm5IZc1XVtqp/dbtFE24aJcQxQ==
=IrN2
-----END PGP SIGNATURE-----

--------------Ne1Q5ccXkKsnDC4xcJfv8OOR--

